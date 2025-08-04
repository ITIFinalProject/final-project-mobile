import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventify_app/generated/l10n.dart';

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
      body: Center(
        child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S.of(context).enter_old_password;
                      }
                      if (val.length < 6) {
                        return S.of(context).password_min_length;
                      }
                      return null;
                    },
                    hint: S.of(context).new_password,
                    controller: newPassController,
                  ),
                  SizedBox(height: 20,),
                  CustomTextFormField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S.of(context).enter_old_password;
                      }
                      return null;
                    },
                    hint: S.of(context).confirm_password,
                    controller: confirmPassController,
                  ),
        
                  CustomElevatedButton(
                    title: S.of(context).save_password,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final authCubit = context.read<AuthCubit>();
                        if (newPassController.text !=
                            confirmPassController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: Text(S.of(context).passwords_do_not_match),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        } else
                          await authCubit
                            ..updatePassword(newPassController.text);
        
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                            content: Text(S.of(context).password_updated_successfully),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.profileView,
                        );
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
