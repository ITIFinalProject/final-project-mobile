import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/messages/chat_view.dart';
import 'package:flutter/material.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages",),
        automaticallyImplyLeading: false,
      ),

      body: ListView(
        children: [
          Card(
            color: ThemeManager.lightPinkColor,
            margin: EdgeInsets.all(10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                      color: ThemeManager.primaryColor
                  )
              ),
              selectedColor: ThemeManager.darkPinkColor,
              leading: CircleAvatar(
                backgroundColor: ThemeManager.primaryColor,
                child: Icon(Icons.group, color: Colors.white),
              ),
              title: Text("Family Get-Together",
                style: TextStyle(color: ThemeManager.primaryColor,),),
              subtitle: const Text("Send a message to your guests"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


}
