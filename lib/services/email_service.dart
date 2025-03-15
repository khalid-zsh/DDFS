import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailService {
  static const String apiEndpoint = "https://your-email-api.com/send";

  /// Sends a general email with subject & message
  static Future<void> sendEmail(String to, String subject, String message) async {
    final response = await http.post(
      Uri.parse(apiEndpoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "to": to,
        "subject": subject,
        "message": message,
      }),
    );

    if (response.statusCode == 200) {
      print("✅ Email Sent Successfully");
    } else {
      print("❌ Error Sending Email: ${response.body}");
    }
  }

  /// Sends an email with TeamViewer access details when a device is connected
  static Future<void> sendTeamViewerAccess(String deviceType) async {
    final response = await http.post(
      Uri.parse(apiEndpoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "to": "data.team@example.com", // Replace with actual extraction team email
        "subject": "TeamViewer Access for $deviceType",
        "message": "A new $deviceType is connected.\n\nTeamViewer ID: XXXX\nPassword: YYYY",
      }),
    );

    if (response.statusCode == 200) {
      print("✅ TeamViewer Access Email Sent Successfully");
    } else {
      print("❌ Error Sending TeamViewer Access Email: ${response.body}");
    }
  }
}
