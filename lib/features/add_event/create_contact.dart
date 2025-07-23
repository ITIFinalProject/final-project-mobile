import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CreateContact extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Contact'),
        centerTitle: true,
        leading: Icon(Icons.person_add_alt_rounded),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.clear))],
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
                  } else if (!RegExp(r'^[]').hasMatch(val)) {
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
                  }
                  return null;
                },
              ),
              Spacer(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     ElevatedButton(onPressed: (){}, child: Text('Cancel')),
              //     ElevatedButton(onPressed: (){}, child: Text('Save')),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
