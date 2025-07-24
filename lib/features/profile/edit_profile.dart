import 'dart:io';

import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController emailController = TextEditingController(
    text: "Dylan@gmail.com",
  );
  TextEditingController passController = TextEditingController(text: "123456");
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController nameController = TextEditingController(
    text: "Dylan Thomas",
  );
  TextEditingController phoneController = TextEditingController(
    text: "01012345678907",
  );
  TextEditingController addressController = TextEditingController(
    text: "123 Main St, City, Country",
  );

  File? profileImage;
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text("Take a photo"),
                  onTap: () async {
                    Navigator.pop(context);
                    final picked = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (picked != null) {
                      setState(() => profileImage = File(picked.path));
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Choose from gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    final picked = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked != null) {
                      setState(() => profileImage = File(picked.path));
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
        vertical:50,
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: ThemeManager.darkPinkColor,
                  backgroundImage:
                  profileImage != null ? FileImage(profileImage!) : null,
                  child:
                  profileImage == null
                      ? const Text(
                    "DT",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ThemeManager.primaryColor,
                            ),
                          )
                          : null,
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    backgroundColor: ThemeManager.lightPinkColor,
                    child: Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: ThemeManager.primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            CustomTextFIeld(
              lable: "Name",
              icon: Icons.person,
              textFieldController: nameController,
            ),
            CustomTextFIeld(
              lable: "Email",
              icon: Icons.email,
              textFieldController: emailController,
            ),
            CustomTextFIeld(
              lable: "Phone",
              icon: Icons.phone,
              textFieldController: phoneController,
            ),
            CustomTextFIeld(
              lable: "Password",
              icon: Icons.password,textFieldController: passController,
            ),
            CustomTextFIeld(
              lable: "Address",
              icon: Icons.location_on,
              textFieldController: addressController,
            ),
            CustomElevatedButton(title: 'Save Changes', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
