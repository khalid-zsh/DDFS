import 'dart:convert';
import 'package:http/http.dart' as http;

class CalendarService {
  static const String _apiKey = "eyJraWQiOiIxY2UxZTEzNjE3ZGNmNzY2YjNjZWJjY2Y4ZGM1YmFmYThhNjVlNjg0MDIzZjdjMzJiZTgzNDliMjM4MDEzNWI0IiwidHlwIjoiSldUIiwiYWxnIjoiRVMyNTYifQ.eyJpc3MiOiJodHRwczovL2F1dGguY2FsZW5kbHkuY29tIiwiaWF0IjoxNzQyNDI3NzE5LCJqdGkiOiJkYmQ0NTFhNS01YmVlLTQwNGUtYmUwNC00OTNiODJmZTE2YmQiLCJ1c2VyX3V1aWQiOiJjOGNiNTE2Ni04N2FhLTRmZmItYTQ4Zi0wYzYxYzM3MmUyMTIiLCJhcHBfdWlkIjoiWDEyWGRIeEFra0I0OExQY0tRNDFxY3dmUHJOa0ZOam9aS1kxU0JISGdjSSIsImV4cCI6MTc0MjQzNDkxOX0.m9Mbe5IXjllvuHv_kc9V8nyPvmCRn6PyHjlYXn0Eunyxv9VELwD9gg2wwc2NXzHL3ikWt6DLT24qsYcWXXfgDw";
  static const String _baseUrl = "https://api.calendly.com/event_types";

  Future<List<dynamic>> fetchEventTypes() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['collection'];
    } else {
      throw Exception("Failed to load event types");
    }
  }
}
