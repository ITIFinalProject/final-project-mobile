import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../../../models.dart/event_model.dart';
import 'custom_text.dart';
import 'custom_text_form_field.dart';

class EventForm extends StatefulWidget {
  final EventModel? event;
  final bool isEdit;
  final Function({
    required String title,
    required String type,
    required String description,
    required String date,
    required String time,
    required String location,
    required int capacity,
    File? imageFile,
    int? templateIndex,
    required String hostName,
  })
  onSubmit;

  const EventForm({
    super.key,
    this.event,
    required this.isEdit,
    required this.onSubmit,
  });

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController startDateController;
  late TextEditingController startTimeController;
  late TextEditingController endDateController;
  late TextEditingController endTimeController;
  late TextEditingController locationController;
  late TextEditingController hostNameController;
  late TextEditingController attendeesController;

  File? pickedImage;
  int? selectedTemplateIndex;
  String? selectedEventType;

  final List<String> eventTypes = [
    "Entertainment",
    "Educational & Business",
    "Cultural & Arts",
    "Sports & Fitness",
    "Technology & Innovation",
    "Travel & Adventure",
  ];

  @override
  void initState() {
    super.initState();

    // ✅ لو تعديل نملي الفورم
    titleController = TextEditingController(text: widget.event?.title ?? '');
    descriptionController = TextEditingController(
      text: widget.event?.description ?? '',
    );
    locationController = TextEditingController(
      text: widget.event?.location ?? '',
    );
    hostNameController = TextEditingController(
      text: widget.event?.hostName ?? '',
    );
    attendeesController = TextEditingController(
      text: widget.event?.capacity.toString() ?? '',
    );
    startDateController = TextEditingController(
      text: widget.event?.date.split(' - ')[0] ?? '',
    );
    endDateController = TextEditingController(
      text:
          widget.event != null && widget.event!.date.contains(' - ')
              ? widget.event!.date.split(' - ')[1]
              : '',
    );

    startTimeController = TextEditingController(
      text: widget.event?.time.split(' - ')[0] ?? '',
    );
    endTimeController = TextEditingController(
      text:
          widget.event != null && widget.event!.time.contains(' - ')
              ? widget.event!.time.split(' - ')[1]
              : '',
    );

    selectedEventType = widget.event?.type;
    selectedTemplateIndex = widget.event?.templateIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText(title: 'Event Title'),
            CustomTextFormField(
              controller: titleController,
              hint: 'Enter event title',
              validator:
                  (val) =>
                      val!.isEmpty ? 'Please enter your event title' : null,
            ),

            CustomText(title: 'Event Type'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DropdownButtonFormField<String>(
                value: selectedEventType,
                items:
                    eventTypes.map((value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                onChanged: (val) => setState(() => selectedEventType = val),
                decoration: CustomInputDecoration.getDecoration(
                  hintText: 'Select event type',
                ),
                validator:
                    (value) =>
                        value == null ? 'Please select your event type' : null,
              ),
            ),

            CustomText(title: 'Event Description'),
            CustomTextFormField(
              controller: descriptionController,
              lines: 2,
              hint: 'Write your event description',
              validator:
                  (val) =>
                      val!.isEmpty
                          ? 'Please enter your event description'
                          : null,
            ),

            // ✅ الحقول الأخرى زي date/time/location زي اللي عندك بالظبط...
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeManager.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String time =
                      '${startTimeController.text} - ${endTimeController.text}';
                  String date =
                      '${startDateController.text} - ${endDateController.text}';

                  widget.onSubmit(
                    title: titleController.text,
                    type: selectedEventType ?? '',
                    description: descriptionController.text,
                    date: date,
                    time: time,
                    location: locationController.text,
                    capacity: int.tryParse(attendeesController.text) ?? 50,
                    imageFile: pickedImage,
                    templateIndex: selectedTemplateIndex,
                    hostName: hostNameController.text,
                  );
                }
              },
              child: Text(
                widget.isEdit ? 'Update Event' : 'Create Event',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
