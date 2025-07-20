import 'package:eventify_app/core/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.register),
            ElevatedButton(onPressed: (){
              FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User? user) {
                if (user == null) {
                  print('User is currently signed out!');
                } else {
                  print('User is signed in!');
                }
              });
              Navigator.pushNamed(context, AppRoutes.login);
            }, child: Text('Go to Login'))
          ],
        ),
      ),
    );
  }

}
