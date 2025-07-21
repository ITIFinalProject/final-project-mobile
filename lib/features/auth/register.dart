import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/features/auth/login.dart';
import 'package:eventify_app/features/auth/widgets/custom_button.dart';
import 'package:eventify_app/features/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
 TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool rememberMe = false;

  bool isLoading = false;
  String errorMessage = '';
  String? selectedGender;



Future<void> registerUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print("User registered: ${userCredential.user?.email}");

    // إضافة بيانات المستخدم في Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'firstName': fNameController.text.trim(),
      'lastName': lNameController.text.trim(),
      'phone': phoneController.text.trim(),
      'email': emailController.text.trim(),
      'gender': selectedGender,
      'address': addressController.text.trim(),
      'dob': dobController.text.trim(),
      'uid': userCredential.user!.uid,
    });

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('weak password');
    } else if (e.code == 'email-already-in-use') {
      print('this email already in use');
    } else {
      print('Error: ${e.message}');
    }
  } catch (e) {
    print(e);
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
        child: ListView(
          children: [
            
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    CustomTextFIeld(
                      lable: "Name",
                      icon: Icons.person_add,
                      lines: 1,
                      color: Color(0xFF42c5a5),
                      textFieldController: fNameController,
                      obscure: false,
                    ),
                    SizedBox(height: 24),
                    CustomTextFIeld(
                      lable: "Phone",
                      icon: Icons.phone_android,
                      lines: 1,
                      color: Color(0xFF42c5a5),
                      textFieldController: phoneController,
                      obscure: false,
                    ),
                    SizedBox(height: 24),
                    CustomTextFIeld(
                      lable: "Email",
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

                    SizedBox(height: 24),

                    CustomTextFIeld(
                      lable: "Confirm Password",
                      icon: Icons.lock_outline,
                      lines: 1,
                      color: Color(0xFF42c5a5),
                      textFieldController: confirmPassController,
                      obscure: true,
                    ),

                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Gender",
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      items: ["Male", "Female"].map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() => selectedGender = val);
                      },
                    ),
               
                    SizedBox(height: 24),

                    CustomButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                            errorMessage = '';
                          });

                          try {
                            await registerUser(
                              emailController.text.trim(),
                              passController.text.trim(),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ),
                            );
                          } catch (e) {
                            setState(() {
                              errorMessage = e.toString();
                            });
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      buttonChild: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : buttonText(text: 'Sign Up'),

                      buttonColor: Color(0xFF42c5a5),

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
                        Text('already have an account ?'),
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
