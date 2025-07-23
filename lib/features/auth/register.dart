import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/auth/login.dart';
import 'package:eventify_app/features/auth/widgets/custom_button.dart';
import 'package:eventify_app/features/auth/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool hidden = true;
  bool hiddenConfirm = true;
  bool isLoading = false;
  String errorMessage = '';
  String? selectedGender;

  Future<void> registerUser(String email, String password) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print("User registered: ${userCredential.user?.email}");
        isLoading = false;
        errorMessage = '';
        setState(() {});
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('weak password');
          isLoading = false;
          errorMessage = 'weak password';
        } else if (e.code == 'email-already-in-use') {
          print('The email address is already in use by another account.');
          isLoading = false;
          errorMessage =
              'The email address is already in use by another account.';
        } else {
          print('Error: ${e.message}');
          isLoading = false;
          errorMessage = 'Error: ${e.message}';
        }
        setState(() {});
      } catch (e) {
        print(e);
        isLoading = false;
        errorMessage = '$e';
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    textFieldController: NameController,
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
                        hiddenConfirm ? Icons.visibility_off : Icons.visibility,
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
                      registerUser(emailController.text, passController.text);
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
  }
}
