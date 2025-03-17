import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailService {
  /// Sends a general email with subject & message
  static Future<void> sendEmail(String to, String subject, String message) async {
    final Email email = Email(
      body: message,
      subject: subject,
      recipients: [to],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      print("✅ Email Sent Successfully");
    } catch (error) {
      print("❌ Error Sending Email: $error");
    }
  }

  /// Sends an email with TeamViewer access details when a device is connected
  static Future<void> sendTeamViewerAccess(String deviceName, String deviceId) async {
    final Email email = Email(
      body: "A new $deviceName is connected.\n\nDevice ID: $deviceId\nTeamViewer ID: XXXX\nPassword: YYYY",
      subject: "TeamViewer Access for $deviceName",
      recipients: ["eyeshotkhalid@gmail.com"], // Replace with actual extraction team email
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      print("✅ TeamViewer Access Email Sent Successfully");
    } catch (error) {
      print("❌ Error Sending TeamViewer Access Email: $error");
    }
  }
}
