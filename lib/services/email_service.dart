import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  static Future<void> sendEmail(String toEmail, String subject, String body) async {
    final smtpServer = gmail("your-email@gmail.com", "your-app-password");
    final message = Message()
      ..from = const Address("your-email@gmail.com", "DDFS Support")
      ..recipients.add(toEmail)
      ..subject = subject
      ..text = body;

    try {
      await send(message, smtpServer);
    } catch (e) {
      print("Error sending email: $e");
    }
  }
}
