import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ddfs/controllers/settings_controller.dart';

class EmailService {
  late final SettingsController _settingsController;

  EmailService() {
    _settingsController = Get.find<SettingsController>();
  }

  static const String apiKey = "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";
  static const String smtpServer = "smtp-relay.brevo.com";
  static const int smtpPort = 587;
  static const String smtpUser = "888af5003@smtp-brevo.com";

  /// Send email using Brevo API
  Future<void> sendEmail(String to, String subject, String message) async {
    final response = await http.post(
      Uri.parse("https://api.brevo.com/v3/smtp/email"),
      headers: {
        "api-key": apiKey,
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "sender": {
          "name": _settingsController.settings.value.emailSender,
          "email": smtpUser
        },
        "to": [
          {
            "email": to
          }
        ],
        "subject": subject,
        "textContent": message,
      }),
    );

    if (response.statusCode == 201) {
      print("✅ Email sent successfully!");
    } else {
      print("❌ Failed to send email: ${response.statusCode} ${response.body}");
    }
  }

  /// Send Unit ID to admin
  Future<void> sendUnitId(String unitId) async {
    await sendEmail(
        _settingsController.settings.value.adminEmail,
        "Unit ID Notification",
        "The current Unit ID is: $unitId"
    );
  }
}