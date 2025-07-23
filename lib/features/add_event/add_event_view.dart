import 'dart:io';

import 'package:eventify_app/features/add_event/widgets/build_preview.dart';
import 'package:eventify_app/features/add_event/widgets/template_choice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  int? currentTemplateIndex;
  File? selectedImage;
  bool showTemplates = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('1 of 5: Customize'), centerTitle: true),
      body: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child:
            showTemplates
                ? TemplateChoice(
                  currentIndex: currentTemplateIndex,
                  selectTemplate: selectTemplate,
                )
                : BuildPreview(
                  selectedImage: selectedImage,
                  selectedTemplate: currentTemplateIndex,
                  pickImage: pickImage,
                  toggleShownTemplates: toggleShowTemplates,
                  onEdit: rest,
                ),
      ),
    );
  }

  void pickImage() async {
    ImagePicker picker = ImagePicker();
    var file = await picker.pickImage(source: ImageSource.gallery);

    selectedImage = file == null ? null : File(file.path);
    setState(() {});
  }

  void selectTemplate(index) {
    currentTemplateIndex = index;
    showTemplates = false;
    setState(() {});
  }

  void toggleShowTemplates() {
    showTemplates = !showTemplates;
    setState(() {});
  }

  rest() {
    selectedImage = null;
    currentTemplateIndex = null;
    showTemplates = false;
    setState(() {});
  }
}
