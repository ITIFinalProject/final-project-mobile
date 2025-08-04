import 'dart:io';

import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/features/add_event/create_contact.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
import 'package:eventify_app/features/profile/cubit/theme_cubit.dart';
import 'package:eventify_app/generated/l10n.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../core/theme.dart';
import 'logic/create_event_cubit/create_event_cubit.dart';

class EventDetailsView extends StatefulWidget {
  const EventDetailsView({super.key});

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController startDateController = TextEditingController();

  TextEditingController startTimeController = TextEditingController();

  TextEditingController endDateController = TextEditingController();

  TextEditingController endTimeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController hostNameController = TextEditingController();
  TextEditingController attendeesController = TextEditingController();

  final List<String> eventTypes = [
    "Entertainment",
    "Educational & Business",
    "Cultural & Arts",
    "Sports & Fitness",
    "Technology & Innovation",
    "Travel & Adventure",
  ];
  String? selectedEventType;
  String? selectedEventCategory;
  File? pickedImage;
  int? selectedTemplateIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments as Map?;

    if (args != null) {
      pickedImage = args['selectedImage'];
      selectedTemplateIndex = args['selectedTemplate'];
    }
  }

  @override
  Widget build(BuildContext context) {
     final thememode = context.watch<ThemeCubit>().state;
    final isDarkMode = thememode == ThemeMode.dark;

    return BlocConsumer<CreateEventCubit, CreateEventState>(
      listener: (context, state) {
        if (state is CreateEventSuccess) {
          Navigator.pushNamed(context, AppRoutes.layout);
        } else if (state is CreateEventError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(S
              .of(context)
              .failed_to_create_event)));
        }
      },
      builder: (BuildContext context, CreateEventState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S
                .of(context)
                .event_details_step),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(title: S
                      .of(context)
                      .event_title),
                  CustomTextFormField(
                    controller: titleController,
                    hint: S
                        .of(context)
                        .enter_event_title,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S
                            .of(context)
                            .please_enter_your_event_title;
                      }
                      return null;
                    },
                  ),
                  CustomText(title: S
                      .of(context)
                      .event_category),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DropdownButtonFormField<String>(
                      value: selectedEventCategory,
                      style: TextStyle(
                        fontSize: 18,
                        color: isDarkMode ? ThemeManager.secondaryColor
                            .withOpacity(0.8) : ThemeManager.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: isDarkMode
                              ? ThemeManager.lightPinkColor
                              : ThemeManager.primaryColor,
                        ),
                        hintText: S
                            .of(context)
                            .select_event_category,
                      ),

                      items:
                          eventTypes.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedEventCategory = val;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S
                              .of(context)
                              .pleaseselect_event_category;
                        }
                        return null;
                      },
                    ),
                  ),
                  CustomText(title: S
                      .of(context)
                      .event_description),
                  CustomTextFormField(
                    controller: descriptionController,
                    lines: 2,
                    hint: S
                        .of(context)
                        .write_your_event_description,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S
                            .of(context)
                            .please_enter_your_event_description;
                      }
                      return null;
                    },
                  ),
                  CustomText(title: S
                      .of(context)
                      .event_type),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DropdownButtonFormField<String>(
                      value: selectedEventType,
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeManager.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: isDarkMode
                              ? ThemeManager.lightPinkColor
                              : ThemeManager.primaryColor,
                        ),
                        hintText: S
                            .of(context)
                            .select_event_type,
                      ),

                      items:
                          ['Private', 'Public'].map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedEventType = val;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S
                              .of(context)
                              .please_select_event_type;
                        }
                        return null;
                      },
                    ),
                  ),
                  CustomText(title: S
                      .of(context)
                      .event_timing),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(title: S
                                .of(context)
                                .start_date),
                            CustomTextFormField(
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return S
                                      .of(context)
                                      .please_enter_your_start_date;
                                }
                                return null;
                              },
                              hint: S
                                  .of(context)
                                  .yyyymmdd,
                              controller: startDateController,
                              onTapped: clickStartDate,
                              prefixIcon: Icons.calendar_month,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(title: S
                                .of(context)
                                .start_time),
                            CustomTextFormField(
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return S
                                      .of(context)
                                      .please_enter_your_start_time;
                                }
                                return null;
                              },
                              hint: '12:00 AM',
                              controller: startTimeController,
                              onTapped: clickStartTime,
                              prefixIcon: Icons.access_time,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(title: S
                                .of(context)
                                .end_date),
                            CustomTextFormField(
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return S
                                      .of(context)
                                      .please_enter_your_end_date;
                                }
                                return null;
                              },
                              hint: S
                                  .of(context)
                                  .yyyymmdd,
                              controller: endDateController,
                              onTapped: clickEndDate,
                              prefixIcon: Icons.calendar_month,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(title: S
                                .of(context)
                                .end_time),
                            CustomTextFormField(
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return S
                                      .of(context)
                                      .please_enter_your_end_time;
                                }
                                return null;
                              },
                              hint: '12:00 AM',
                              controller: endTimeController,
                              onTapped: clickEndTime,
                              prefixIcon: Icons.access_time,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomText(title: S
                      .of(context)
                      .location),
                  CustomTextFormField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S
                            .of(context)
                            .please_enter_your_event_location;
                      }
                      return null;
                    },
                    hint: S
                        .of(context)
                        .location,
                    controller: locationController,
                    prefixIcon: Icons.location_on,
                  ),
                  CustomElevatedButton(
                    title: S
                        .of(context)
                        .open_google_maps,
                    onPressed: openMapToGetLocation,
                  ),
                  CustomText(title: S
                      .of(context)
                      .attendees),
                  CustomTextFormField(
                    controller: attendeesController,
                    hint: S
                        .of(context)
                        .enter_number_of_attendees,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S
                            .of(context)
                            .please_enter_number_of_attendees;
                      }
                      return null;
                    },
                  ),
                  CustomText(title: S
                      .of(context)
                      .hosted_by),
                  CustomTextFormField(
                    controller: hostNameController,
                    hint: S
                        .of(context)
                        .enter_host_name,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S
                            .of(context)
                            .please_enter_host_name;
                      }
                      return null;
                    },
                  ),
                  state is CreateEventLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: ThemeManager.primaryColor,
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.all(15),
                        child: CustomElevatedButton(
                          title:
                          selectedEventType == 'Private'
                              ? S
                              .of(context)
                              .addguests
                              : S
                              .of(context)
                              .next_preview,
                          onPressed: () {
                            // لو Public → يكمل createEvent عادي
                            createEvent();
                          },
                        ),
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  createEvent() {
    if (_formKey.currentState!.validate()) {
      if (!_isDateTimeRangeValid()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S
                .of(context)
                .end_datetime_must_be_after_start_datetime),
          ),
        );
        return;
      }
      String time = '${startTimeController.text} - ${endTimeController.text}';
      String dateTime =
          (startDateController.text == endDateController.text)
              ? startDateController.text
              : '${startDateController.text} _ ${endDateController.text}';
      final event = EventModel(
        id: const Uuid().v4(),
        hostId: '123',
        title: titleController.text.trim(),
        type: selectedEventType ?? '',
        description: descriptionController.text.trim(),
        date: dateTime,
        time: time,
        location: locationController.text.trim(),
        hostName: hostNameController.text.trim(),
        capacity: int.tryParse(attendeesController.text) ?? 50,
        bannerUrl: pickedImage?.path ?? '',
        templateIndex: selectedTemplateIndex,
        category: selectedEventCategory ?? '',
      );
      if (selectedEventType == 'Private') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateContact(event: event)),
        );
      } else {
        context.read<CreateEventCubit>().createEvent(
          title: titleController.text.trim(),
          type: selectedEventType ?? '',
          time: time,
          location: locationController.text.trim(),
          hostName: hostNameController.text.trim(),
          capacity: int.tryParse(attendeesController.text) ?? 50,
          imageFile: pickedImage,
          templateIndex: selectedTemplateIndex,
          category: selectedEventCategory ?? '',
          date: dateTime,
          description: descriptionController.text,
        );
      }
    }
  }

  bool _isDateTimeRangeValid() {
    try {
      final startDate = DateFormat(
        'yyyy-MM-dd',
      ).parse(startDateController.text);
      final endDate = DateFormat('yyyy-MM-dd').parse(endDateController.text);
      final startTime = DateFormat('HH:mm').parse(startTimeController.text);
      final endTime = DateFormat('HH:mm').parse(endTimeController.text);

      final start = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        startTime.hour,
        startTime.minute,
      );
      final end = DateTime(
        endDate.year,
        endDate.month,
        endDate.day,
        endTime.hour,
        endTime.minute,
      );

      return end.isAfter(start);
    } catch (_) {
      return false;
    }
  }

  void clickStartDate() async {
    DateTime? _date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    if (_date != null) {
      startDateController.text = DateFormat('yyyy-MM-dd').format(_date);
      setState(() {});
    }
  }

  void clickEndDate() async {
    DateTime? _date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    if (_date != null) {
      endDateController.text = DateFormat('yyyy-MM-dd').format(_date);
      setState(() {});
    }
  }

  void clickStartTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      var dateNow = DateTime.now();
      var dateTime = DateTime(
        dateNow.year,
        dateNow.month,
        dateNow.day,
        time.hour,
        time.minute,
      );
      startTimeController.text = DateFormat('HH:mm ').format(dateTime);
    }
  }

  void clickEndTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      var dateNow = DateTime.now();
      var dateTime = DateTime(
        dateNow.year,
        dateNow.month,
        dateNow.day,
        time.hour,
        time.minute,
      );
      endTimeController.text = DateFormat('HH:mm').format(dateTime);
    }
  }

  openMapToGetLocation() async {
    final result = await Navigator.pushNamed(context, AppRoutes.mapPicker);

    if (result != null && result is String) {
      locationController.text = result;
    }
  }
}
