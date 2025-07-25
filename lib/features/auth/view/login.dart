import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/auth/view/register.dart';
import 'package:eventify_app/features/auth/view/widgets/custom_button.dart';
import 'package:eventify_app/features/auth/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool hidden = true;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.layout);
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
              FocusScope.of(
                context,
              ).unfocus(); // علشان اما اضغط بره الfocus يقفل
            },
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFIeld(
                        lable: "Email",
                        icon: Icons.email_rounded,
                        textFieldController: emailController,
                        obscure: false,
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.forgetPassword);
                        },
                        child: Text(
                          "forget password ?",
                          style: TextStyle(
                            color: ThemeManager.secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),

                      SizedBox(height: 24),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              authCubit.signIn(
                                emailController.text.trim(),
                                passController.text.trim(),
                              );
                            }
                          },
                          buttonChild:
                          isLoading
                              ? CircularProgressIndicator(
                            color: ThemeManager.lightPinkColor,
                          )
                              : buttonText(text: "LOGIN"),

                          buttonColor: ThemeManager.primaryColor,

                          vPadding: 14,
                          hPadding: 100,
                        ),
                      ),
                      if (errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
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
                            'create new account ?',
                            style: TextStyle(color: ThemeManager.primaryColor),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return RegisterView();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up Now",
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
