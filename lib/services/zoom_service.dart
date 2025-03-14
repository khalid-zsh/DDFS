import 'package:http/http.dart' as http;
import 'dart:convert';

class ZoomService {
  final String apiKey;
  final String apiSecret;
  final String baseUrl = 'https://api.zoom.us/v2';

  ZoomService({required this.apiKey, required this.apiSecret});

  Future<Map<String, dynamic>> createMeeting(String topic, String startTime) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/me/meetings'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'topic': topic,
        'type': 2,
        'start_time': startTime,
        'duration': 60,
        'timezone': 'UTC',
        'settings': {
          'host_video': true,
          'participant_video': true,
        },
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create meeting');
    }
  }
}