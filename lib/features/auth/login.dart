import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/auth/register.dart';
import 'package:eventify_app/features/auth/widgets/custom_button.dart';
import 'package:eventify_app/features/auth/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool isLoading = false;
  String errorMessage = '';
  bool hidden = true;

  Future<void> LoginUser(String email, String password) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print("User logged in: ${userCredential.user?.email}");
        Navigator.pushReplacementNamed(context, AppRoutes.layout);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          errorMessage = 'Wrong password provided for that user.';
        } else {
          print('Error: ${e.message}');
          errorMessage = 'Error: ${e.message}';
        }
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // علشان اما اضغط بره الfocus يقفل
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        LoginUser(emailController.text, passController.text);
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
  }
}
