import 'package:eventify_app/core/routes.dart';
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

Future<void> LoginUser(String email, String password) async{
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
  }
  
  catch (e) {
    
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 100,
                ),
                child: Column(
                  children: [
                    CustomTextFIeld(
                      lable: "Email",
                      icon: Icons.email_rounded,
                      lines: 1,
                      color: Color(0xFF42c5a5),
                      textFieldController: emailController,
                      obscure: false,
                    ),
                    
                    CustomTextFIeld(
                      lable: "Password",
                      icon: Icons.lock_outline_rounded,
                      lines: 1,
                      color: Color(0xFF42c5a5),
                      textFieldController: passController,
                      obscure: hidden,
                      suffixIcon:
                    hidden ? Icons.visibility_off : Icons.visibility,
                    onPressedIcon: () {
                      hidden = !hidden;
                      setState(() {});
                    },
                    ),

                    SizedBox(height: 24),

                    CustomButton(
                      onPressed: () {
                        LoginUser(emailController.text, passController.text);
                      },
                      buttonChild: isLoading
                          ? CircularProgressIndicator()
                          : buttonText(text: "LOGIN"),

                      buttonColor: Color(0xFF42c5a5),

                      vPadding: 14,
                      hPadding: 100,
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
          ),
        ),
      ),
    );
  }
}
