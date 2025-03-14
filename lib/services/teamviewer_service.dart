import 'package:http/http.dart' as http;
import 'dart:convert';

class TeamViewerService {
  final String apiKey;
  final String baseUrl = 'https://webapi.teamviewer.com/api/v1';

  TeamViewerService({required this.apiKey});

  Future<Map<String, dynamic>> createSession() async {
    final response = await http.post(
      Uri.parse('$baseUrl/sessions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'groupid': 'YOUR_GROUP_ID',
        'description': 'Support Session',
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create session');
    }
  }
}