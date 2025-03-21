import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ddfs/controllers/settings_controller.dart';

class CalendarService {
  final SettingsController _settingsController = Get.find<SettingsController>();

  String get _apiKey => _settingsController.settings.value.apiKey;
  String get _organizationUuid => _settingsController.settings.value.organizationUuid;

  // 📌 Fetch Available Event Types from Calendly
  Future<List<dynamic>> fetchEventTypes() async {
    final url = Uri.parse(
        "https://api.calendly.com/event_types?organization=https://api.calendly.com/organizations/$_organizationUuid");

    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['collection']; // Extract event types
    } else {
      throw Exception('Failed to load event types: ${response.body}');
    }
  }

  // 📌 Schedule an Event via API (No WebView Required)
  Future<void> scheduleEvent({
    required String eventTypeUri, // Unique event type ID from Calendly
    required String inviteeEmail, // Email of the person scheduling
    required String inviteeName,  // Name of the invitee
    required String startTime,    // ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
  }) async {
    final url = Uri.parse("https://api.calendly.com/scheduled_events");

    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "event_type": eventTypeUri,
      "start_time": startTime,
      "invitee": {
        "email": inviteeEmail,
        "name": inviteeName,
      }
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      print("✅ Event scheduled successfully: ${response.body}");
    } else {
      print("❌ Failed to schedule event: ${response.body}");
    }
  }
}