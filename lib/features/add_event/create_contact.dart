import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CreateContact extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Contact'),
        centerTitle: true,
        leading: Icon(
          Icons.person_add_alt_rounded, color: ThemeManager.primaryColor,),
        actions: [
          IconButton(onPressed: () {
            Navigator.pop(context);
          },
              icon: Icon(Icons.clear, color: ThemeManager.primaryColor,))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(title: 'Name'),
              CustomTextFormField(
                controller: nameController,
                hint: 'Enter name',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              CustomText(title: 'E-mail Address'),
              CustomTextFormField(
                controller: nameController,
                hint: 'Enter e-mail address',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter e-mail address';
                  } else if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(val)) {
                    return '';
                  }
                  return null;
                },
              ),
              CustomText(title: 'Phone'),
              CustomTextFormField(
                controller: nameController,
                hint: 'Enter phone',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter phone';
                  } else if (!RegExp(r"^01[0125]\d{8}").hasMatch(val)) {
                    return 'Please enter a valid phone like 01012345678.';
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.45,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(onPressed: () {}, title: ('Cancel')),
                  CustomElevatedButton(onPressed: () {}, title: ('Save')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
