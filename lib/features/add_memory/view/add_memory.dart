import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:flutter/material.dart';

class AddMemory extends StatelessWidget {
  const AddMemory({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as EventModel;
    return Scaffold(
      appBar: AppBar(title: Text('${args.title} Memory'),),
      body: Column(children: [

      ],),
      floatingActionButton: FloatingActionButton(onPressed: (){

      },
      backgroundColor: ThemeManager.primaryColor,
      child: Icon(Icons.add_a_photo_outlined, color: Colors.white,size: 30,),),
    );
  }
}