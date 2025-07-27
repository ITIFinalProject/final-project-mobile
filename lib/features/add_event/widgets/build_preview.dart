import 'dart:io';

import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
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
                  color: ThemeManager.darkPinkColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: ThemeManager.darkPinkColor.withBlue(100)
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        ThemeManager.darkPinkColor,
                        ThemeManager.lightPinkColor
                      ]
                  )
              ),

              child: Center(child: Text('Your Event Cover Here',
                style: TextStyle(
                  color: ThemeManager.secondaryColor, fontSize: 18,),)),
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(child: CustomElevatedButton(
                  title: 'Upload Image', onPressed: pickImage,)),

                Expanded(
                  child: CustomElevatedButton(
                    onPressed: toggleShownTemplates,
                    title: 'Choose Template',
                  ),
                ),

              ],
            ),
          ],
        )
        : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child:
                    (selectedImage == null)
                        ? Image.asset(
                      'assets/images/template$selectedTemplate.jpg',
                      height: size.height * 0.6,
                    )
                        : Image.file(selectedImage!, height: size.height * 0.6,
                      fit: BoxFit.cover,),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: ThemeManager.secondaryColor,
                child: IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit, color: ThemeManager.lightPinkColor),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        CustomElevatedButton(
          onPressed: () {

            Navigator.pushNamed(context, AppRoutes.eventDetails,arguments: {
              'selectedImage':selectedImage,
              'selectedTemplate': selectedTemplate,
            });
            
          },
          title: ('Next: Event Details'),
        ),
      ],
        );
  }
}
