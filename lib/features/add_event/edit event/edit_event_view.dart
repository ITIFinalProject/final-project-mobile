// import 'dart:io';

// import 'package:eventify_app/core/theme.dart';
// import 'package:eventify_app/features/add_event/logic/create_event_cubit/create_event_cubit.dart';
// import 'package:eventify_app/models.dart/event_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class EditEventView extends StatefulWidget {
//   final EventModel event;

//   const EditEventView({super.key, required this.event});

//   @override
//   State<EditEventView> createState() => _EditEventViewState();
// }

// class _EditEventViewState extends State<EditEventView> {
//   // Controllers
//   late TextEditingController titleController;
//   late TextEditingController typeController;
//   late TextEditingController descriptionController;
//   late TextEditingController dateController;
//   late TextEditingController timeController;
//   late TextEditingController locationController;
//   late TextEditingController capacityController;

//   File? newImageFile;
//   int? selectedTemplateIndex;

//   @override
//   void initState() {
//     super.initState();
//     // ✅ تعيين القيم الحالية في الفورم
//     titleController = TextEditingController(text: widget.event.title);
//     typeController = TextEditingController(text: widget.event.type);
//     descriptionController = TextEditingController(
//       text: widget.event.description,
//     );
//     dateController = TextEditingController(text: widget.event.date);
//     timeController = TextEditingController(text: widget.event.time);
//     locationController = TextEditingController(text: widget.event.location);
//     capacityController = TextEditingController(
//       text: widget.event.capacity.toString(),
//     );
//     selectedTemplateIndex = widget.event.templateIndex;
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     typeController.dispose();
//     descriptionController.dispose();
//     dateController.dispose();
//     timeController.dispose();
//     locationController.dispose();
//     capacityController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ThemeManager.lightPinkColor,
//       appBar: AppBar(
//         title: const Text("Edit Event"),
//         backgroundColor: ThemeManager.primaryColor,
//       ),
//       body: BlocConsumer<CreateEventCubit, CreateEventState>(
//         listener: (context, state) {
//           if (state is CreateEventSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text(" Event updated successfully")),
//             );
//             Navigator.pop(context, true); //  نرجع لليست بعد التعديل
//           } else if (state is CreateEventError) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text(" ${state.message}")));
//           }
//         },
//         builder: (context, state) {
//           if (state is CreateEventLoading) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: ThemeManager.primaryColor,
//               ),
//             );
//           }
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 // 🖼 صورة
//                 GestureDetector(
//                   onTap: () async {
//                     // TODO: افتح ImagePicker واختار صورة جديدة
//                   },
//                   child: Container(
//                     height: 180,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       image: DecorationImage(
//                         image:
//                             newImageFile != null
//                                 ? FileImage(newImageFile!)
//                                 : (widget.event.bannerUrl != null &&
//                                         widget.event.bannerUrl!.isNotEmpty
//                                     ? NetworkImage(widget.event.bannerUrl!)
//                                     : (widget.event.templateIndex !=null)?AssetImage(
//                                           'assets/images/template${widget.event.templateIndex}.jpg',
//                                         ):NetworkImage('https://i.pinimg.com/1200x/2b/7f/a9/2b7fa911454725f7fd5b9d2f4dd41046.jpg')
//                                         as ImageProvider),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // 📝 الحقول
//                 _buildTextField(titleController, "Title"),
//                 _buildTextField(typeController, "Type"),
//                 _buildTextField(
//                   descriptionController,
//                   "Description",
//                   maxLines: 3,
//                 ),
//                 _buildTextField(dateController, "Date"),
//                 _buildTextField(timeController, "Time"),
//                 _buildTextField(locationController, "Location"),
//                 _buildTextField(
//                   capacityController,
//                   "Capacity",
//                   keyboard: TextInputType.number,
//                 ),

//                 const SizedBox(height: 20),

//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ThemeManager.primaryColor,
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 14,
//                       horizontal: 30,
//                     ),
//                   ),
//                   onPressed: () {
//                     context.read<CreateEventCubit>().updateEvent(
//                       eventId: widget.event.id,
//                       title: titleController.text,
//                       type: typeController.text,
//                       description: descriptionController.text,
//                       date: dateController.text,
//                       time: timeController.text,
//                       location: locationController.text,
//                       capacity:
//                           int.tryParse(capacityController.text) ??
//                           widget.event.capacity,
//                       imageFile: newImageFile,
//                       templateIndex: selectedTemplateIndex,
//                       hostName: widget.event.hostName,
//                       category: widget.event.category,
//                     );
//                     Navigator.pop(context);
//                   },
//                   child: const Text(
//                     "Update Event",
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTextField(
//     TextEditingController controller,
//     String label, {
//     int maxLines = 1,
//     TextInputType keyboard = TextInputType.text,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,
//         keyboardType: keyboard,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/logic/create_event_cubit/create_event_cubit.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
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
    startDateController = TextEditingController(text: widget.event.date.split('-')[0]);
    startTimeController = TextEditingController(text: widget.event.time.split('-')[0]);
    endDateController = TextEditingController(text: widget.event.date.split('-')[1]);
    endTimeController = TextEditingController(text: widget.event.time.split('-')[1]);
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
                      decoration: CustomInputDecoration.getDecoration(
                        hintText: 'Select category',
                      ),
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
                      decoration: CustomInputDecoration.getDecoration(
                        hintText: 'Select type',
                      ),
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
                          
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeManager.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 30,
                      ),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      updateEvent();
                    },
                    child: const Text(
                      "Update Event",
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
      String dateTime = (startDateController.text == endDateController.text)?startDateController.text:'${startDateController.text} - ${endDateController.text}';
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
        imageFile: selectedImage ?? newImageFile,
        templateIndex: selectedTemplateIndex,
        category: selectedCategory ?? '',
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
