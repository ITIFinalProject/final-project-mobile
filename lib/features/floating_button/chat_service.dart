import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatService {
  static final String? _apiKey =
      dotenv.env['OPENAI_API_KEY']; // ← حطي مفتاحك هنا
  static const String _url = 'https://api.openai.com/v1/chat/completions';

  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",

          "messages": [
            {"role": "user", "content": message},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['choices'][0]['message']['content'];
        return reply.trim();
      } else {
        return "A error occurred: ${response.statusCode}";
      }
    } catch (e) {
      return "There was an error connected to AI: $e";
    }
  }
}
