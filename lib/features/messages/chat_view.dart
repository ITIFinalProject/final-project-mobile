// import 'package:eventify_app/core/theme.dart';
// import 'package:flutter/material.dart';
//
// class ChatPage extends StatefulWidget {
//   final String eventId;
//
//   const ChatPage({super.key, required this.eventId});
//
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _messageController = TextEditingController();
//
//   void _sendMessage() {
//     String message = _messageController.text.trim();
//     if (message.isNotEmpty) {
//       // Send message logic here
//       print("Sent: $message");
//       _messageController.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Family Get-Together"),
//         actions: const [
//           // Padding(
//           //   padding: EdgeInsets.only(right: 16),
//           //   child: Center(child: Text("15 Participants")),
//           // ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: Text(
//                 "Messages are sent to each guest privately.",
//                 style: TextStyle(color: ThemeManager.secondaryColor),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       fillColor: ThemeManager.primaryColor,
//                       filled: true,
//                       hintText: "Write a message",
//                       hintStyle: TextStyle(
//                           color: ThemeManager.lightPinkColor
//                       ),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20)
//                       ),
//                       isDense: true,
//                       contentPadding:
//                       EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 CircleAvatar(
//                   backgroundColor: ThemeManager.lightPinkColor,
//                   child: IconButton(
//                     icon: const Icon(
//                         Icons.send, color: ThemeManager.primaryColor),
//                     onPressed: _sendMessage,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventify_app/generated/l10n.dart';
import '../auth/cubit/auth_cubit.dart';
import '../auth/cubit/auth_state.dart';
import 'cubit/event_chat_cubit.dart';
import 'cubit/event_chat_state.dart';

class ChatPage extends StatefulWidget {
  final String eventId;

  const ChatPage({super.key, required this.eventId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late EventChatCubit chatCubit;
  String? eventName;

  void loadEventName() async {
    final doc = await FirebaseFirestore.instance.collection('events').doc(
        widget.eventId).get();
    if (doc.exists && doc.data()!.containsKey('title')) {
      setState(() {
        eventName = doc['title'];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final authState = context
        .read<AuthCubit>()
        .state;
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String userName = (authState is AuthSuccess) ? authState.user.name ??
        'Anonymous' : 'Guest';

    chatCubit = EventChatCubit(
      eventId: widget.eventId,
      firestore: FirebaseFirestore.instance,
    );

    chatCubit.initializeUser(userId: userId, userName: userName);
    chatCubit.loadMessages();
    loadEventName();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    chatCubit.close();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text;
    chatCubit.sendMessage(text);
    _messageController.clear();
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 80,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = context
        .watch<AuthCubit>()
        .state;
    if (authState is! AuthSuccess) {
      return Scaffold(
        body: Center(
            child: Text(S.of(context).login_required_message)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(eventName ??  S.of(context).chat)),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<EventChatCubit, EventChatState>(
              bloc: chatCubit,
              builder: (context, state) {
                if (state is EventChatLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is EventChatLoaded) {
                  final messages = state.messages;
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isMe = msg.senderId ==
                          FirebaseAuth.instance.currentUser?.uid;
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment
                            .centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe
                                ? ThemeManager.primaryColor
                                : ThemeManager.darkPinkColor.withOpacity(0.9),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: isMe ? Radius.circular(12) : Radius
                                  .circular(0),
                              bottomRight: isMe ? Radius.circular(0) : Radius
                                  .circular(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isMe)
                                Text(
                                  msg.senderName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                              if (!isMe) SizedBox(height: 4),
                              Text(
                                msg.message,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text(S.of(context).no_messages_yet));
                }
              },
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
                      fillColor: ThemeManager.primaryColor.withOpacity(0.1),
                      filled: true,
                      hintText:  S.of(context).write_a_message,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: ThemeManager.lightPinkColor,
                  child: IconButton(
                    icon: Icon(Icons.send, color: ThemeManager.primaryColor),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
