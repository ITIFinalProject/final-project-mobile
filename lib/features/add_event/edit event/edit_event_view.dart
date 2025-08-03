
import 'dart:io';
import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/logic/create_event_cubit/create_event_cubit.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
import 'package:eventify_app/features/profile/cubit/theme_cubit.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditEventView extends StatefulWidget {
  final EventModel event;

  const EditEventView({super.key, required this.event});

  @override
  State<EditEventView> createState() => _EditEventViewState();
}

class _EditEventViewState extends State<EditEventView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController capacityController;
  late TextEditingController startDateController;
  late TextEditingController startTimeController;
  late TextEditingController endDateController;
  late TextEditingController endTimeController;
  String? selectedCategory;
  String? selectedEventType;
  File? selectedImage;

  final List<String> eventTypes = [
    "Entertainment",
    "Educational & Business",
    "Cultural & Arts",
    "Sports & Fitness",
    "Technology & Innovation",
    "Travel & Adventure",
  ];
  final List<String> eventVisibility = ['Private', 'Public'];
  File? newImageFile;
  int? selectedTemplateIndex;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.event.title);
    descriptionController = TextEditingController(
      text: widget.event.description,
    );
    locationController = TextEditingController(text: widget.event.location);
    capacityController = TextEditingController(
      text: widget.event.capacity.toString(),
    );
    if(widget.event.date.contains('_')) {
      startDateController = TextEditingController(text: widget.event.date.split('_')[0]);
      endDateController = TextEditingController(text: widget.event.date.split('_')[1]);
    } else {
      startDateController = TextEditingController(text: widget.event.date);
      endDateController = TextEditingController(text: widget.event.date);
    }
    startTimeController = TextEditingController(text: widget.event.time.split('-')[0]);
    endTimeController = TextEditingController(text: widget.event.time.split('-')[1].trim());
    selectedCategory = widget.event.category;
    selectedEventType = widget.event.type;
  
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
     final thememode = context.watch<ThemeCubit>().state;
    final isDarkMode = thememode == ThemeMode.dark;

    return Scaffold(


      appBar: AppBar(title: const Text("Edit Event")),
      body: BlocConsumer<CreateEventCubit, CreateEventState>(
        listener: (context, state) {
          if (state is CreateEventSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(" Event updated successfully")),
            );
            Navigator.pop(context, true); //  نرجع لليست بعد التعديل
          } else if (state is CreateEventError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(" ${state.message}")));
          }
        },
        builder: (context, state) {
          if (state is CreateEventLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ThemeManager.primaryColor,
              ),
            );
          }
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🖼 صورة
                  GestureDetector(
                    onTap: () async {
                      // TODO: افتح ImagePicker واختار صورة جديدة
                    },
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image:
                              newImageFile != null
                                  ? FileImage(newImageFile!)
                                  : (widget.event.bannerUrl != null &&
                                          widget.event.bannerUrl!.isNotEmpty
                                      ? NetworkImage(widget.event.bannerUrl!)
                                      : (widget.event.templateIndex != null)
                                      ? AssetImage(
                                        'assets/images/template${widget.event.templateIndex}.jpg',
                                      )
                                      : NetworkImage(
                                            'https://i.pinimg.com/1200x/2b/7f/a9/2b7fa911454725f7fd5b9d2f4dd41046.jpg',
                                          )
                                          as ImageProvider),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const CustomText(title: "Event Title"),
                  CustomTextFormField(
                    controller: titleController,
                    hint: 'Enter event title',
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter title'
                                : null,
                  ),

                  const CustomText(title: "Description"),
                  CustomTextFormField(
                    controller: descriptionController,
                    hint: 'Enter event description',
                    lines: 3,
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter description'
                                : null,
                  ),

                  const CustomText(title: "Location"),
                  CustomTextFormField(
                    controller: locationController,
                    hint: 'Enter event location',
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter location'
                                : null,
                                onTapped: openMapToGetLocation
                  ),

                  const CustomText(title: "Category"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DropdownButtonFormField<String>(
                      value: selectedCategory,
                      // decoration: CustomInputDecoration.getDecoration(
                      //   hintText: 'Select category',
                      // ),
                      items:
                          eventTypes
                              .map(
                                (cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat),
                                ),
                              )
                              .toList(),
                      onChanged: (val) => setState(() => selectedCategory = val),
                      validator:
                          (val) => val == null ? 'Please select category' : null,
                    ),
                  ),

                  const CustomText(title: "Event Type"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DropdownButtonFormField<String>(
                      value: selectedEventType,
                      // decoration: CustomInputDecoration.getDecoration(
                      //   hintText: 'Select type',
                      // ),
                      items:
                          eventVisibility
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ),
                              )
                              .toList(),
                      onChanged: (val) => setState(() => selectedEventType = val),
                      validator:
                          (val) => val == null ? 'Please select type' : null,
                    ),
                  ),

                  const CustomText(title: "Capacity"),
                  CustomTextFormField(
                    controller: capacityController,
                    hint: 'Enter number of attendees',
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter capacity';
                      }
                      if (int.tryParse(val) == null) {
                        return 'Enter valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

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
                                      hint: 'yyyy-MM-dd',
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
                                      hint: '12:00 ',
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
                                      hint: 'yyyy-MM-dd',
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
                                      hint: '12:00 ',
                                      controller: endTimeController,
                                      onTapped: clickEndTime,
                                      prefixIcon: Icons.access_time,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode?ThemeManager.lightPinkColor:ThemeManager.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 30,
                      ),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      updateEvent();
                    },
                    child:  Text(
                      "Update Event",
                      style: TextStyle(color:isDarkMode?ThemeManager.primaryColor:ThemeManager.lightPinkColor, fontSize: 16),
                    ),
                                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void updateEvent() {
    if (_formKey.currentState!.validate()) {
      if (!_isDateTimeRangeValid()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("End date/time must be after start date/time")),
        );
        return;
      }
      String time = '${startTimeController.text} - ${endTimeController.text}';
      String dateTime = (startDateController.text == endDateController.text)?startDateController.text:'${startDateController.text} _ ${endDateController.text}';
      context.read<CreateEventCubit>().updateEvent(
        eventId: widget.event.id,
        hostName: widget.event.hostName,
        title: titleController.text.trim(),
        type: selectedEventType ?? '',
        description: descriptionController.text.trim(),
        date: dateTime,
        time: time,
        location: locationController.text.trim(),
        capacity:  int.tryParse(capacityController.text) ?? 50,
        imageFile: selectedImage,
        templateIndex: selectedTemplateIndex,
        category: selectedCategory ?? '',
      );
    }
  }
    bool _isDateTimeRangeValid() {
    try {
      final startDate = DateFormat('yyyy-MM-dd').parse(
          startDateController.text);
      final endDate = DateFormat('yyyy-MM-dd').parse(endDateController.text);
      final startTime = DateFormat('HH:mm').parse(startTimeController.text);
      final endTime = DateFormat('HH:mm').parse(endTimeController.text);

      final start = DateTime(
          startDate.year, startDate.month, startDate.day, startTime.hour,
          startTime.minute);
      final end = DateTime(
          endDate.year, endDate.month, endDate.day, endTime.hour,
          endTime.minute);
print('Start: $start');
print('End: $end');

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
      startTimeController.text = DateFormat('HH:mm').format(dateTime);
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
