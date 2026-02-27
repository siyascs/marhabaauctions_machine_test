import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class VisionApiService {
  VisionApiService({required this.apiKey, this.model = 'gpt-4o-mini'});

  final String apiKey;
  final String model;

  Future<String> describeImage(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(<String, dynamic>{
        'model': model,
        'messages': <Map<String, dynamic>>[
          <String, dynamic>{
            'role': 'user',
            'content': <Map<String, dynamic>>[
              <String, dynamic>{
                'type': 'text',
                'text':
                    'Describe this image in a clear and concise way for a user in a Flutter mobile app.',
              },
              <String, dynamic>{
                'type': 'image_url',
                'image_url': <String, String>{
                  'url': 'data:image/jpeg;base64,$base64Image',
                },
              },
            ],
          },
        ],
        'max_tokens': 180,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('LLM request failed (${response.statusCode}): ${response.body}');
    }

    final Map<String, dynamic> payload =
        jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic>? choices = payload['choices'] as List<dynamic>?;
    if (choices == null || choices.isEmpty) {
      throw Exception('No description returned by model.');
    }

    final String? description =
        choices.first['message']?['content']?.toString().trim();
    if (description == null || description.isEmpty) {
      throw Exception('Empty description returned by model.');
    }

    return description;
  }
}
