import 'dart:io';

import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/models/user_model.dart';
import '../../profile/cubit/theme_cubit.dart';
import '../cubit/report_cubit.dart';
import '../cubit/report_state.dart';
import '../models/report_model.dart';

class ReportView extends StatefulWidget {
  final EventModel event;
  final UserModel user;

  const ReportView({super.key, required this.event, required this.user});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  String? selectedReasonId;
  final TextEditingController customReasonController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? evidenceImageFile;

  final List<Map<String, String>> reasons = [
    {
      "id": "spam",
      "label": "Spam",
      "description": "Event appears to be spam or promotional content",
    },
    {
      "id": "violence",
      "label": "Violence/Threats",
      "description": "Event promotes harassment or discrimination",
    },
    {
      "id": "harassment",
      "label": "Harassment",
      "description": "Event contains violent content or threats",
    },
    {
      "id": "scam_fraud",
      "label": "Scam / Fraud",
      "description": "Event appears to be fraudulent or a scam",
    },
    {
      "id": "copyright",
      "label": "Copyright Violation",
      "description": "Event uses copyrighted material without permission",
    },
    {
      'id': "inappropriate_content",
      'label': "Inappropriate Content",
      'description': "Event contains offensive or inappropriate material",
    },
    {
      'id': "misleading_info",
      'label': "Misleading Information",
      'description': "Event details are false or misleading",
    },
    {
      "id": "other",
      "label": "Other",
      "description": "Other reason not listed above",
    },
  ];

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        evidenceImageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final isDarkMode = themeMode == ThemeMode.dark;
    return BlocProvider(
      create: (_) => ReportCubit(),
      child: BlocConsumer<ReportCubit, ReportState>(
        listener: (context, state) {
          if (state is ReportSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Report submitted successfully"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is ReportError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ReportCubit>();

          return Scaffold(
            appBar: AppBar(title: Text('${widget.event.title} Report')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select a reason:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...reasons.map((reason) {
                    return Card(
                      child: RadioListTile<String>(
                        title: Text(reason['label']!),
                        subtitle: Text(reason['description']!),
                        value: reason['id']!,
                        groupValue: selectedReasonId,
                        onChanged:
                            (value) => setState(() => selectedReasonId = value),
                        fillColor: const WidgetStatePropertyAll(
                          ThemeManager.primaryColor,
                        ),
                      ),
                    );
                  }).toList(),
                  if (selectedReasonId == 'other') ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: customReasonController,
                      decoration: InputDecoration(
                        labelText: 'Custom Reason',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color:
                              isDarkMode
                                  ? ThemeManager.lightPinkColor
                                  : ThemeManager.primaryColor,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Additional details (optional)',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        color:
                            isDarkMode
                                ? ThemeManager.lightPinkColor
                                : ThemeManager.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Evidence (optional)'),
                  const SizedBox(height: 8),
                  if (evidenceImageFile != null)
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color:
                              isDarkMode
                                  ? ThemeManager.darkPinkColor
                                  : ThemeManager.primaryColor,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          evidenceImageFile!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  TextButton.icon(
                    onPressed: pickImage,
                    icon: Icon(
                      Icons.image,
                      color:
                          isDarkMode
                              ? ThemeManager.darkPinkColor
                              : ThemeManager.primaryColor,
                    ),
                    label: Text(
                      "Upload Image",
                      style: TextStyle(
                        color:
                            isDarkMode
                                ? ThemeManager.darkPinkColor
                                : ThemeManager.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (state is ReportSubmitting)
                    Center(
                      child: CircularProgressIndicator(
                        color:
                            isDarkMode
                                ? ThemeManager.lightPinkColor
                                : ThemeManager.primaryColor,
                      ),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomElevatedButton(
                          title: 'Cancel',
                          onPressed: () => Navigator.pop(context),
                        ),
                        CustomElevatedButton(
                          title: 'Submit',
                          onPressed: () {
                            if (selectedReasonId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select a reason"),
                                ),
                              );
                              return;
                            }

                            final reportModel = ReportModel(
                              eventId: widget.event.id,
                              eventTitle: widget.event.title,
                              eventHostId: widget.event.hostId ?? '',
                              reporterId: widget.user.uid ?? '',
                              reporterName: widget.user.name ?? '',
                              reason: selectedReasonId!,
                              customReason:
                                  selectedReasonId == 'other'
                                      ? customReasonController.text
                                      : null,
                              description: descriptionController.text,
                              createdAt: DateTime.now(),
                            );
                            cubit.submitReport(
                              report: reportModel,
                              imageFile: evidenceImageFile,
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
