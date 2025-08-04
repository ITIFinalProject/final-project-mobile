import 'package:eventify_app/features/floating_button/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:eventify_app/generated/l10n.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // final List<String> messages = ["Ask Ai about anything"];
  late List<String> messages = [];
  final TextEditingController _controller = TextEditingController();


  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (messages.isEmpty) {
    // بنستخدم didChangeDependencies لأن S.of(context) بيحتاج context جاهز
    messages = [S.of(context).ask_ai_about_anything];
  }
}

  void sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(text);
      messages.add("...");
    });

    _controller.clear();

    final reply = await ChatService.sendMessage(text);

    setState(() {
      messages.removeLast();
      messages.add(reply);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          S.of(context).ai_chat,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1B3C53),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = index % 2 != 0;

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: ChatBubble(text: message, isUser: isUser),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:  InputDecoration(
                      hintText: S.of(context).write_your_message_here,
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      // لون خلفية الصندوق (اختياري)
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        // مستدير أكثر
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        borderSide: BorderSide(
                          color: Color(0xFF1B3C53),
                          width: 2,
                        ), // عند التركيز
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send, color: Color(0xFF1B3C53)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUser ? const Color(0xFF1B3C53) : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
          bottomLeft: Radius.circular(isUser ? 12 : 0),
          bottomRight: Radius.circular(isUser ? 0 : 12),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: isUser ? Colors.white : Colors.black87),
      ),
    );
  }
}
