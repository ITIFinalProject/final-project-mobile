import 'dart:io';

import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/logic/create_event_cubit/create_event_cubit.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditEventView extends StatefulWidget {
  final EventModel event;

  const EditEventView({super.key, required this.event});

  @override
  State<EditEventView> createState() => _EditEventViewState();
}

class _EditEventViewState extends State<EditEventView> {
  // Controllers
  late TextEditingController titleController;
  late TextEditingController typeController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController locationController;
  late TextEditingController capacityController;

  File? newImageFile;
  int? selectedTemplateIndex;

  @override
  void initState() {
    super.initState();
    // ✅ تعيين القيم الحالية في الفورم
    titleController = TextEditingController(text: widget.event.title);
    typeController = TextEditingController(text: widget.event.type);
    descriptionController = TextEditingController(
      text: widget.event.description,
    );
    dateController = TextEditingController(text: widget.event.date);
    timeController = TextEditingController(text: widget.event.time);
    locationController = TextEditingController(text: widget.event.location);
    capacityController = TextEditingController(
      text: widget.event.capacity.toString(),
    );
    selectedTemplateIndex = widget.event.templateIndex;
  }

  @override
  void dispose() {
    titleController.dispose();
    typeController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    locationController.dispose();
    capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.lightPinkColor,
      appBar: AppBar(
        title: const Text("Edit Event"),
        backgroundColor: ThemeManager.primaryColor,
      ),
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 🖼 صورة
                GestureDetector(
                  onTap: () async {
                    // TODO: افتح ImagePicker واختار صورة جديدة
                  },
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image:
                            newImageFile != null
                                ? FileImage(newImageFile!)
                                : (widget.event.image != null &&
                                        widget.event.image!.isNotEmpty
                                    ? NetworkImage(widget.event.image!)
                                    : AssetImage(
                                          'assets/images/template${widget.event.templateIndex}.jpg',
                                        )
                                        as ImageProvider),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 📝 الحقول
                _buildTextField(titleController, "Title"),
                _buildTextField(typeController, "Type"),
                _buildTextField(
                  descriptionController,
                  "Description",
                  maxLines: 3,
                ),
                _buildTextField(dateController, "Date"),
                _buildTextField(timeController, "Time"),
                _buildTextField(locationController, "Location"),
                _buildTextField(
                  capacityController,
                  "Capacity",
                  keyboard: TextInputType.number,
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeManager.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 30,
                    ),
                  ),
                  onPressed: () {
                    context.read<CreateEventCubit>().updateEvent(
                      eventId: widget.event.id,
                      title: titleController.text,
                      type: typeController.text,
                      description: descriptionController.text,
                      date: dateController.text,
                      time: timeController.text,
                      location: locationController.text,
                      capacity:
                          int.tryParse(capacityController.text) ??
                          widget.event.capacity,
                      imageFile: newImageFile,
                      templateIndex: selectedTemplateIndex,
                      hostName: widget.event.hostName,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Update Event",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
