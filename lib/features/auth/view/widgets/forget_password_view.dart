import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: TextStyle(color: ThemeManager.primaryColor),
                ),
                backgroundColor: ThemeManager.lightPinkColor,
              ),
            );
            Navigator.pop(context);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error, style: TextStyle(color: Colors.red)),
                backgroundColor: ThemeManager.lightPinkColor,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFIeld(
                    lable: "Email",
                    icon: Icons.email,
                    textFieldController: emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthCubit>().resetPassword(
                          emailController.text.trim(),
                        );
                      }
                    },
                    buttonChild:
                        isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : buttonText(text: "Send Reset Link"),
                    buttonColor: ThemeManager.primaryColor,
                    vPadding: 14,
                    hPadding: 50,
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
