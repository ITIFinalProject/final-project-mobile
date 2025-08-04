// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/services.dart';
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:http/http.dart' as http;
//
// class FCMService {
//   // static const String _serviceAccountPath =
//   //     'assets/eventify-app-c92d4-29f0234c150b.json';
//    static const String _serviceAccountPath =
//         'assets/eventify-app-c92d4-firebase-adminsdk-fbsvc-df9be473a8.json';//✅ Use a secure & fresh file name
//   static const String _projectId =
//       'eventify-app-c92d4'; // ✅ Make sure this matches your Firebase project ID
//
//   /// Fetches access token using a service account
//   Future<AccessCredentials> getAccessToken() async {
//     try {
//       // Load service account JSON from assets
//       final serviceAccountJson = await rootBundle.loadString(
//         _serviceAccountPath,
//       );
//
//       // Parse the credentials
//       final serviceAccount = ServiceAccountCredentials.fromJson(
//         serviceAccountJson,
//       );
//
//       // Required scopes for Firebase Cloud Messaging
//       final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
//
//       // Authenticate and get client
//       final authClient = await clientViaServiceAccount(serviceAccount, scopes);
//
//       return authClient.credentials;
//     } catch (e) {
//       log('🔴 Failed to load service account credentials: $e');
//       rethrow;
//     }
//   }
//
//   /// Sends FCM notification using v1 HTTP endpoint
//   Future<void> sendNotification({
//     required String fcmToken,
//     required String title,
//     required String body,
//   }) async {
//     try {
//       final credentials = await getAccessToken();
//       final accessToken = credentials.accessToken.data;
//
//       final uri = Uri.parse(
//         'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send',
//       );
//
//       final message = {
//         "message": {
//           "token": fcmToken,
//           "notification": {"title": title, "body": body},
//           "android": {"priority": "high"},
//         },
//       };
//
//       final response = await http.post(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $accessToken',
//         },
//         body: jsonEncode(message),
//       );
//
//       if (response.statusCode == 200) {
//         log('✅ FCM notification sent successfully.');
//       } else {
//         log('❌ FCM send failed: ${response.statusCode} - ${response.body}');
//       }
//     } catch (e, stackTrace) {
//       log('🔴 Error sending FCM notification: $e');
//       log('StackTrace: $stackTrace');
//     }
//   }
// }