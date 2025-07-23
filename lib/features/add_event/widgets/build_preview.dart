import 'dart:io';

import 'package:eventify_app/core/routes.dart';
import 'package:flutter/material.dart';

class BuildPreview extends StatelessWidget {
  File? selectedImage;
  int? selectedTemplate;
  VoidCallback pickImage;
  VoidCallback toggleShownTemplates;
  VoidCallback onEdit;

  BuildPreview({
    super.key,
    required this.selectedImage,
    required this.selectedTemplate,
    required this.pickImage,
    required this.toggleShownTemplates,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return (selectedTemplate == null && selectedImage == null)
        ? Column(
          children: [
            Container(
              width: size.width * 0.7,
              height: size.height * 0.6,
              margin: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),

              child: Center(child: Text('Your Event Cover Here')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: pickImage,
                  label: Text('Upload Image'),
                  icon: Icon(Icons.upload_file),
                ),
                ElevatedButton.icon(
                  onPressed: toggleShownTemplates,
                  label: Text('Choose Template'),
                  icon: Icon(Icons.view_module_outlined),
                ),
              ],
            ),
          ],
        )
        : Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child:
                      (selectedImage == null)
                          ? Image.asset(
                            'assets/images/template${selectedTemplate}.jpg',
                          )
                          : Image.file(selectedImage!),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      onPressed: onEdit,
                      icon: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.eventDetails);
              },
              child: Text('Next: Event Details'),
            ),
          ],
        );
  }
}
