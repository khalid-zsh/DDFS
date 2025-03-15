import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeamViewerService {
  static const MethodChannel _channel = MethodChannel('com.ddfs/teamviewer');
  static const String apiKey = "your-teamviewer-api-key"; // 🔴 Replace with real API key

  /// Launch TeamViewer
  static Future<void> launchTeamViewer() async {
    try {
      await _channel.invokeMethod('launchTeamViewer');
    } on PlatformException catch (e) {
      print("❌ Error launching TeamViewer: ${e.message}");
    }
  }

  /// Activate TeamViewer Black Screen
  static Future<void> enableBlackScreen() async {
    try {
      final response = await http.post(
        Uri.parse("https://webapi.teamviewer.com/api/v1/sessions/enableBlackScreen"),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print("✅ Black Screen Enabled Successfully");
      } else {
        print("❌ Failed to Enable Black Screen: ${response.body}");
      }
    } catch (e) {
      print("❌ Error enabling Black Screen: $e");
    }
  }

  /// Check if TeamViewer session is active
  static Future<bool> isSessionActive() async {
    final response = await http.get(
      Uri.parse("https://webapi.teamviewer.com/api/v1/sessions"),
      headers: {"Authorization": "Bearer $apiKey"},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["sessions"].isNotEmpty;
    } else {
      print("❌ Error checking session: ${response.body}");
      return false;
    }
  }
}
