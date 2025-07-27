import 'package:eventify_app/features/add_event/widgets/custom_text.dart';
import 'package:eventify_app/features/add_event/widgets/custom_text_form_field.dart';
import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
import 'package:eventify_app/features/profile/change%20password/change_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyOldPass extends StatefulWidget {
  const VerifyOldPass({super.key});

  @override
  State<VerifyOldPass> createState() => _VerifyOldPassState();
}

class _VerifyOldPassState extends State<VerifyOldPass> {
  TextEditingController passController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,
        vertical:70
        ),
        child: Column(
          children: [
            
          CustomTextFormField(validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your old password';
                    }
                    return null;
                  },  hint: "Enter Old Password", controller:passController ),
        CustomElevatedButton(title: "Verify", onPressed: ()async{
          final authCubit = context.read<AuthCubit>();

    bool isCorrect = await authCubit.verifyPassword(passController.text);

    if (isCorrect) {
      // روح لصفحة تغيير الباسورد
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ChangePass()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Wrong password. Try again.")),
      );
    }
        })
          ],
        ),
      ),
    );
  }
}
