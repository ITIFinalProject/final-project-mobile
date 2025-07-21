import 'package:eventify_app/features/auth/register.dart';
import 'package:eventify_app/features/auth/widgets/custom_button.dart';
import 'package:eventify_app/features/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool isLoading = false;
  String errorMessage = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // علشان اما اضغط بره الfocus يقفل
        },
        child: ListView(
          children: [

            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 100,
                ),
                child: Column(
                  children: [
                    CustomTextFIeld(
                      lable: "Email Adress",
                      icon: Icons.email_rounded,
                      lines: 1,
                      color: Color(0xFF42c5a5),
                      textFieldController: emailController,
                      obscure: false,
                    ),
                    SizedBox(height: 24),
                    CustomTextFIeld(
                      lable: "Password",
                      icon: Icons.lock_outline_rounded,
                      lines: 1,
                      color: Color(0xFF42c5a5),
                      textFieldController: passController,
                      obscure: true,
                    ),

                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                        ),
                        Text("Remember Me"),
                      ],
                    ),

                    SizedBox(height: 24),

                    CustomButton(
                      onPressed: () {
                       
                      },
                      buttonChild: isLoading
                          ? CircularProgressIndicator()
                          : buttonText(text: "LOGIN"),

                      buttonColor: Color(0xFF42c5a5),

                      vPadding: 14,
                      hPadding: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('create new account ?'),
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
                              color: Color(0xFF42c5a5),
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
          ],
        ),
      ),
    );
  }
}
