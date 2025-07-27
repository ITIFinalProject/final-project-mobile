import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your old password';
                    }
                    if (val.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  hint: "New Password",
                  controller: newPassController,
                ),
                CustomTextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your old password';
                    }
                    return null;
                  },
                  hint: "confirm Password",
                  controller: confirmPassController,
                ),

                CustomElevatedButton(
                  title: "Save Password",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final authCubit = context.read<AuthCubit>();
                      if (newPassController.text !=
                          confirmPassController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Passwords do not match"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else
                        await authCubit
                          ..updatePassword(newPassController.text);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password updated successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.profileView);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
