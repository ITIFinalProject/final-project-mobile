import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/auth/view/login.dart';
import 'package:eventify_app/features/auth/view/widgets/custom_button.dart';
import 'package:eventify_app/features/auth/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hidden = true;
  bool hiddenConfirm = true;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        } else if (state is AuthFailure) {
          errorMessage = state.error;
        }
      },
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();
        final isLoading = state is AuthLoading;
        return Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFIeld(
                        lable: "Name",
                        icon: Icons.person_add,
                        textFieldController: nameController,
                      ),
                      CustomTextFIeld(
                        lable: "Phone",
                        icon: Icons.phone_android,

                        textFieldController: phoneController,
                      ),
                      CustomTextFIeld(
                        lable: "Email",
                        icon: Icons.email_rounded,
                        textFieldController: emailController,
                      ),
                      CustomTextFIeld(
                        lable: "Password",
                        icon: Icons.lock_outline_rounded,
                        textFieldController: passController,
                        obscure: hidden,
                        suffixIcon:
                        hidden ? Icons.visibility_off : Icons.visibility,
                        onPressedIcon: () {
                          hidden = !hidden;
                          setState(() {});
                        },
                      ),
                      CustomTextFIeld(
                        lable: "Confirm Password",
                        icon: Icons.lock_outline,
                        textFieldController: confirmPassController,
                        obscure: hiddenConfirm,
                        suffixIcon:
                        hiddenConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onPressedIcon: () {
                          hiddenConfirm = !hiddenConfirm;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Confirm Password....';
                          } else if (value != passController.text) {
                            return 'Passwords must match';
                          }
                          return null;
                        },
                      ),

                      CustomTextFIeld(
                        lable: "address",
                        icon: Icons.location_on,
                        textFieldController: addressController,
                      ),

                      CustomButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            authCubit.signUp(
                              emailController.text.trim(),
                              passController.text.trim(),
                              nameController.text.trim(),
                              phoneController.text.trim(),
                              addressController.text.trim(),
                            );
                          }
                        },
                        buttonChild:
                        isLoading
                            ? const CircularProgressIndicator(
                          color: ThemeManager.lightPinkColor,
                        )
                            : buttonText(text: 'Sign Up'),

                        buttonColor: ThemeManager.primaryColor,

                        vPadding: 14,
                        hPadding: 100,
                      ),
                      if (errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(child: Divider(thickness: 1,
                                color: ThemeManager.secondaryColor)),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8),
                              child: Text('or', style: TextStyle(
                                  color: ThemeManager.primaryColor)),
                            ),
                            Expanded(child: Divider(thickness: 1,
                                color: ThemeManager.secondaryColor)),
                          ],
                        ),
                      ),

                      Row(
                        spacing: 15,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<AuthCubit>().signInWithGoogle();
                            },
                            child: CircleAvatar(
                              backgroundColor: ThemeManager.primaryColor,
                              radius: 28,
                              backgroundImage: AssetImage(
                                  'assets/images/google_logo.png'),
                            ),
                          ),
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: ThemeManager.primaryColor,
                              radius: 28,
                              backgroundImage: AssetImage(
                                  'assets/images/facebook_logo.jpg'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account ?',
                            style: TextStyle(color: ThemeManager.primaryColor),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LoginView();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Login In Now",
                              style: TextStyle(
                                color: ThemeManager.secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
