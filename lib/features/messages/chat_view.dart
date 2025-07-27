import 'package:eventify_app/core/theme.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String eventId;

  const ChatPage({super.key, required this.eventId});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      // Send message logic here
      print("Sent: $message");
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Family Get-Together"),
        actions: const [
          // Padding(
          //   padding: EdgeInsets.only(right: 16),
          //   child: Center(child: Text("15 Participants")),
          // ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Messages are sent to each guest privately.",
                style: TextStyle(color: ThemeManager.secondaryColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      fillColor: ThemeManager.primaryColor,
                      filled: true,
                      hintText: "Write a message",
                      hintStyle: TextStyle(
                          color: ThemeManager.lightPinkColor
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      isDense: true,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: ThemeManager.lightPinkColor,
                  child: IconButton(
                    icon: const Icon(
                        Icons.send, color: ThemeManager.primaryColor),
                    onPressed: _sendMessage,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
