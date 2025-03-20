import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ddfs/controllers/settings_controller.dart';

class EmailService {
  late final SettingsController _settingsController;

  EmailService() {
    _settingsController = Get.find<SettingsController>();
  }

  static const String apiKey = "e36118cf4ea5786f3365950a07dabdd8-3d4b3a2a-93db4ef4";
  static const String domain = "sandbox4c2278c2529a44b9b11308205bae3638.mailgun.org";
  static const String smtpUser = "postmaster@$domain";

  /// Send email using Mailgun API
  Future<void> sendEmail(String to, String subject, String message) async {
    final response = await http.post(
      Uri.parse("https://api.mailgun.net/v3/$domain/messages"),
      headers: {
        "Authorization": "Basic " + base64Encode(utf8.encode("api:$apiKey")),
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: {
        "from": "${_settingsController.settings.value.emailSender} <$smtpUser>",
        "to": to,
        "subject": subject,
        "text": message,
      },
    );

    if (response.statusCode == 200) {
      print("✅ Email sent successfully!");
    } else {
      print("❌ Failed to send email: ${response.body}");
    }
  }

  /// Send Unit ID to admin
  Future<void> sendUnitId(String unitId) async {
    await sendEmail(
        "admin@example.com",
        "Unit ID Notification",
        "The current Unit ID is: $unitId"
    );
  }
}