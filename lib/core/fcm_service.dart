import 'dart:convert';
import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';


class FCMService {

  static const String _serviceAccountPath = 'assets/eventify-app-c92d4-29f0234c150b.json';

  static const String _projectId = 'eventify-app-c92d4';

  static Future<void> sendNotification({
    required String fcmToken,
    required String title,
    required String body,
  }) async {
    final serviceAccount = File(_serviceAccountPath);
    final jsonCredentials = serviceAccount.readAsStringSync();

    final credentials = ServiceAccountCredentials.fromJson(jsonCredentials);
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = await clientViaServiceAccount(credentials, scopes);

    final uri = Uri.parse('https://fcm.googleapis.com/v1/projects/$_projectId/messages:send');

    final message = {
      "message": {
        "token": fcmToken,
        "notification": {
          "title": title,
          "body": body,
        },
        "android": {
          "priority": "high",
        },
      }
    };

    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(message),
    );

    print('FCM Response: ${response.statusCode} - ${response.body}');

    client.close();
  }
}
