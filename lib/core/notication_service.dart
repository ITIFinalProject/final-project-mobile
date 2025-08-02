import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventify_app/features/auth/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class NotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  initFCM() async {
    await messaging.requestPermission();

    String? token = await messaging.getToken();
    print("🔐 FCM Token: $token");
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print("🚪 Notification opened ${message.notification?.title}");
      if (message.data.isNotEmpty) {
        final data = message.data;
        final eventTitle = data['eventTitle'];

        // عرض Dialog للمستخدم
        showDialog(
          context: navigatorKey.currentContext!,
          builder:
              (_) => AlertDialog(
                title: Text("You have been invited to event $eventTitle"),
                content: Text("Do you want to join yo us"),
                actions: [
                  TextButton(
                    onPressed: () {
                      print('rejected');
                      _handleInvitation(data, false);
                      Navigator.pop(navigatorKey.currentContext!);
                    },
                    child: Text("cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      print('accepted');
                      // await joinEvent(eventId);
                      _handleInvitation(data, true);
                      Navigator.pop(navigatorKey.currentContext!);
                    },
                    child: Text("Accept"),
                  ),
                ],
              ),
        );
      }
    });

    // FirebaseMessaging.onMessage.listen((RemoteMessage message){
    //   print("🚪 Notification  ${message.notification?.title}");
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data.isNotEmpty) {
        final data = message.data;
        final eventTitle = data['eventTitle'];

        // عرض Dialog للمستخدم
        showDialog(
          context: navigatorKey.currentContext!,
          builder:
              (_) => AlertDialog(
                title: Text("You have been invited to event $eventTitle"),
                content: Text("Do you want to join yo us"),
                actions: [
                  TextButton(
                    onPressed: () {
                      print('rejected');
                      _handleInvitation(data, false);

                      Navigator.pop(navigatorKey.currentContext!);
                    },
                    child: Text("cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      print('accepted');
                      _handleInvitation(data, true);
                      Navigator.pop(navigatorKey.currentContext!);
                    },
                    child: Text("Accept"),
                  ),
                ],
              ),
        );
      }
    });
  }

  Future<void> _handleInvitation(Map docId, bool accepted) async {
    final status = accepted ? 'accepted' : 'rejected';

    // 1. Update the notification status
    final notifRef = FirebaseFirestore.instance
        .collection('users')
        .doc(docId['guestId'])
        .collection('notifications')
        .doc(docId['notificationId']); // ✅ Use the correct document ID

    await notifRef.update({'status': status});

    // 2. Send notification to the host
    final docRefHost = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId['hostId'])
        .get();

    final user = UserModel.fromFireStore(docRefHost.data()!);

    await NotificationService().sendPushNotification(
      deviceToken: user.fcmToken!,
      title: "Invitation $status",
      body:
      "${docId['guestName']} has $status your invitation to event ${docId['eventTitle']}.",
    );
  }

  Future<AccessCredentials> _getAccessToken() async {
    final serviceAccountPath = dotenv.env['PATH_TO_SECRET'];

    String serviceAccountJson = await rootBundle.loadString(
      serviceAccountPath!,
    );

    // log("json: $serviceAccountJson");
    final serviceAccount = ServiceAccountCredentials.fromJson(
      serviceAccountJson,
    );

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = await clientViaServiceAccount(serviceAccount, scopes);
    return client.credentials;
  }

  Future<bool> sendPushNotification({
    required String deviceToken,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    if (deviceToken.isEmpty) return false;

    final credentials = await _getAccessToken();
    final accessToken = credentials.accessToken.data;
    final projectId = dotenv.env['PROJECT_ID'];

    log("accessToken: $dotenv.env['PROJECT_ID']");

    final url = Uri.parse(
      'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
    );

    final message = {
      'message': {
        'token': deviceToken,
        'notification': {'title': title, 'body': body},
        'data': data ?? {},
      },
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully.');
      return true;
    } else {
      print('Failed to send notification: ${response.body}');
      return false;
    }
  }
}
