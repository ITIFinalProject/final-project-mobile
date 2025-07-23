import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/theme.dart';

class EventDetailsView extends StatefulWidget {
  EventDetailsView({super.key});

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

  final List<String> eventTypes = [
    "Entertainment",
    "Educational & Business",
    "Cultural & Arts",
    "Sports & Fitness",
    "Technology & Innovation",
    "Travel & Adventure",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('2 of 5: Event Details'), centerTitle: true),
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
              CustomText(title: 'Event Type'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: DropdownButtonFormField<String>(
                  style: TextStyle(
                      fontSize: 18, color: ThemeManager.primaryColor),
                  borderRadius: BorderRadius.circular(15),
                  decoration: CustomInputDecoration.getDecoration(
                    hintText: 'Select event type',
                  ),

                  items:
                  eventTypes.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please select your event type';
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
                onTapped: openMapToGetLocation,
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
              Padding(
                padding: const EdgeInsets.all(15),
                child: CustomElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.createContacts);
                }, title: ('Next: Preview')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var selectedStartDate;

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

  var selectedEndDate;

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
        time.hour,
        time.minute,
      );
      endTimeController.text = DateFormat('hh:mm a').format(dateTime);
    }
  }

  openMapToGetLocation() {}
}
