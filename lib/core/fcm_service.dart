// import 'dart:convert';
// import 'dart:io';
// import 'package:googleapis_auth/auth_io.dart';
//
//
// class FCMService {
//
//   static const String _serviceAccountPath = 'assets/eventify-app-c92d4-29f0234c150b.json';
//
//   static const String _projectId = 'eventify-app-c92d4';
//
//   static Future<void> sendNotification({
//     required String fcmToken,
//     required String title,
//     required String body,
//   }) async {
//     final serviceAccount = File(_serviceAccountPath);
//     final jsonCredentials = serviceAccount.readAsStringSync();
//
//     final credentials = ServiceAccountCredentials.fromJson(jsonCredentials);
//     final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
//
//     final client = await clientViaServiceAccount(credentials, scopes);
//
//     final uri = Uri.parse('https://fcm.googleapis.com/v1/projects/$_projectId/messages:send');
//
//     final message = {
//       "message": {
//         "token": fcmToken,
//         "notification": {
//           "title": title,
//           "body": body,
//         },
//         "android": {
//           "priority": "high",
//         },
//       }
//     };
//
//     final response = await client.post(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(message),
//     );
//
//     print('FCM Response: ${response.statusCode} - ${response.body}');
//
//     client.close();
//   }
// }
import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class FCMService {
  static const String _serviceAccountPath = 'assets/eventify-app-c92d4-firebase-adminsdk-fbsvc-df9be473a8.json';
  static const String _projectId = 'eventify-app-c92d4';


 static Future<ServiceAccountCredentials> loadServiceAccountCredentials() async {
    final byteData = await rootBundle.load(_serviceAccountPath);
    final jsonString = utf8.decode(byteData.buffer.asUint8List());
    return ServiceAccountCredentials.fromJson(jsonString);
  }

  static Future<void> sendNotification({
    required String fcmToken,
    required String title,
    required String body,
  }) async {
    try {

      final credentials = await loadServiceAccountCredentials();
      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
      final AccessCredentials accessCredentials = await obtainAccessCredentialsViaServiceAccount(
        credentials,
        scopes,
        http.Client(), // Provide a basic http.Client
      );

      final String accessToken = accessCredentials.accessToken.data;
      print('--- FCM Access Token for Postman: $accessToken ---');
      print('--- Token expires in: ${accessCredentials.accessToken.expiry.difference(DateTime.now()).inMinutes} minutes ---');



      final client = await clientViaServiceAccount(credentials, scopes);
     print(client.credentials);
      final uri = Uri.parse('https://fcm.googleapis.com/v1/projects/$_projectId/messages:send');

      final message = {
        "message": {
          "token": fcmToken,
          "notification": {
            "title": title,
            "body": body,
          }
        }
      };
      print('Before Posting');
      final response = await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message),
      );

      print('FCM Response: ${response.statusCode} - ${response.body}');

      client.close();
    } catch (e, stackTrace) {
      print('Error sending FCM notification: $e');
      print('StackTrace: $stackTrace');
      // Re-throw or handle the error appropriately
      rethrow;
    }
  }
}