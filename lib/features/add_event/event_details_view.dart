import 'dart:io';

import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Map?;

    if (args != null) {
      pickedImage = args['selectedImage'];
      selectedTemplateIndex = args['selectedTemplate'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEventCubit, CreateEventState>(
      listener: (context, state) {
        if (state is CreateEventSuccess) {
          Navigator.pushNamed(context, AppRoutes.layout);
        } else if (state is CreateEventError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Failed to create event")));
        }
      },
      builder: (BuildContext context, CreateEventState state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('2 of 5: Event Details'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomText(title: 'Event Title'),
                          CustomTextFormField(
                            controller: titleController,
                            hint: 'Enter event title',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter your event title';
                              }
                              return null;
                            },
                          ),
                          CustomText(title: 'Event Category'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: DropdownButtonFormField<String>(
                              value: selectedEventCategory,
                              style: TextStyle(
                                fontSize: 18,
                                color: ThemeManager.primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              decoration: CustomInputDecoration.getDecoration(
                                hintText: 'Select event category',
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
                                  return 'please select your event category';
                                }
                                return null;
                              },
                            ),
                          ),
                          CustomText(title: 'Event Description'),
                          CustomTextFormField(
                            controller: descriptionController,
                            lines: 2,
                            hint: 'Write your event description',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter your event description';
                              }
                              return null;
                            },
                          ),
                          CustomText(title: 'Event Type'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: DropdownButtonFormField<String>(
                              value: selectedEventType,
                              style: TextStyle(
                                fontSize: 18,
                                color: ThemeManager.primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              decoration: CustomInputDecoration.getDecoration(
                                hintText: 'Select event type',
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
                                  return 'please select your event type';
                                }
                                return null;
                              },
                            ),
                          ),
                          CustomText(title: 'Event Timing'),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(title: 'Start Date'),
                                    CustomTextFormField(
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'please enter your start date';
                                        }
                                        return null;
                                      },
                                      hint: 'DD/MM/YY',
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
                                    CustomText(title: 'Start Time'),
                                    CustomTextFormField(
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'please enter your start time';
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
                                    CustomText(title: 'End Date'),
                                    CustomTextFormField(
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'please enter your end date';
                                        }
                                        return null;
                                      },
                                      hint: 'DD/MM/YY',
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
                                    CustomText(title: 'End Time'),
                                    CustomTextFormField(
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'please enter your end time';
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
                          CustomText(title: 'Location'),
                          CustomTextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter your event location';
                              }
                              return null;
                            },
                            hint: 'Location',
                            controller: locationController,
                            prefixIcon: Icons.location_on,
                          ),
                          CustomElevatedButton(
                            title: 'Open Google maps',
                            onPressed: openMapToGetLocation,
                          ),
                          CustomText(title: 'Attendees'),
                          CustomTextFormField(
                            controller: attendeesController,
                            hint: 'Enter number of attendees',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter number of attendees';
                              }
                              return null;
                            },
                          ),
                          CustomText(title: 'Hosted By'),
                          CustomTextFormField(
                            controller: hostNameController,
                            hint: 'Enter host name',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter your host name';
                              }
                              return null;
                            },
                          ),
                          state is CreateEventLoading ? Center(
                              child: CircularProgressIndicator(
                                  color: ThemeManager.primaryColor)) : Padding(
                            padding: const EdgeInsets.all(15),
                            child: CustomElevatedButton(
                              onPressed: createEvent,
                              title: ('Next: Preview'),
                            ),
                          ),
                        ]))
            ));
      },
    );
  }

  createEvent() {
    if (_formKey.currentState!.validate()) {
      if (!_isDateTimeRangeValid()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("End date/time must be after start date/time")),
        );
        return;
      }
      String time = '${startTimeController.text} - ${endTimeController.text}';
      String dateTime = (startDateController.text == endDateController.text)?startDateController.text:'${startDateController.text} - ${endDateController.text}';
      context.read<CreateEventCubit>().createEvent(
        title: titleController.text.trim(),
        type: selectedEventType ?? '',
        description: descriptionController.text.trim(),
        date: dateTime,
        time: time,
        location: locationController.text.trim(),
        hostName: hostNameController.text.trim(),
        capacity:
        int.tryParse(attendeesController.text) ?? 50,
        imageFile: pickedImage,
        templateIndex: selectedTemplateIndex,
          category: selectedEventCategory ?? ''
      );
    }
  }

  bool _isDateTimeRangeValid() {
    try {
      final startDate = DateFormat('dd/MM/yyyy').parse(
          startDateController.text);
      final endDate = DateFormat('dd/MM/yyyy').parse(endDateController.text);
      final startTime = DateFormat('hh:mm a').parse(startTimeController.text);
      final endTime = DateFormat('hh:mm a').parse(endTimeController.text);

      final start = DateTime(
          startDate.year, startDate.month, startDate.day, startTime.hour,
          startTime.minute);
      final end = DateTime(
          endDate.year, endDate.month, endDate.day, endTime.hour,
          endTime.minute);

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
      startDateController.text = DateFormat('dd/MM/yyyy').format(_date);
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
      endDateController.text = DateFormat('dd/MM/yyyy').format(_date);
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
      startTimeController.text = DateFormat('hh:mm a').format(dateTime);
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
      endTimeController.text = DateFormat('hh:mm a').format(dateTime);
    }
  }


  openMapToGetLocation() async {
    final result = await Navigator.pushNamed(context, AppRoutes.mapPicker);

    if (result != null && result is String) {
      locationController.text = result;
    }
  }

}
