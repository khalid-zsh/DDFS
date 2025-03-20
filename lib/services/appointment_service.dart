import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ddfs/controllers/settings_controller.dart';

class CalendarService {
  final SettingsController _settingsController = Get.find<SettingsController>();

  Future<List<dynamic>> fetchEventTypes() async {
    final url = Uri.parse(_settingsController.settings.value.appointmentUrl);
    final headers = {
      'Authorization': 'Bearer YOUR_API_Key',
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['event_types'];
    } else {
      throw Exception('Failed to load event types');
    }
  }
}