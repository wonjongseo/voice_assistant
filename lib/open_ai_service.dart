import 'dart:convert';

import 'package:http/http.dart' as http;

String secretApiKey = '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';

class OpenAIService {
  final List<Map<String, String>> messages = [];

  String _dallEUrl = 'https://api.openai.com/v1/images/generations';
  String _chatGptUrl = 'https://api.openai.com/v1/chat/completions';
  Future<String> isArtPromptApi(String prompt) async {
    try {
      final res = await http.post(Uri.parse(_chatGptUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $secretApiKey'
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            'messages': [
              {
                'role': 'user',
                'content':
                    'Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no'
              }
            ]
          }));

      if (res.statusCode == 200) {
        print('res.body: ${res.body}');

        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];

        content = content.trim();

        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final res = await dallEApi(prompt);
            return res;

          default:
            final res = await chatGpiApi(prompt);
            return res;
        }
      }

      return 'An Internal error occurred.';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGpiApi(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(Uri.parse(_chatGptUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $secretApiKey'
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            'messages': messages,
          }));

      if (res.statusCode == 200) {
        print('res.body: ${res.body}');

        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];

        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });

        return content;
      }

      return 'An Internal error occurred.';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEApi(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(Uri.parse(_dallEUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $secretApiKey'
          },
          body: jsonEncode({
            'prompt': prompt,
            'n': 1,
          }));

      if (res.statusCode == 200) {
        print('res.body: ${res.body}');

        String imageUrl = jsonDecode(res.body)['data'][0]['url'];

        imageUrl = imageUrl.trim();

        messages.add({
          'role': 'assistant',
          'content': imageUrl,
        });

        return imageUrl;
      }

      return 'An Internal error occurred.';
    } catch (e) {
      return e.toString();
    }
  }
}
