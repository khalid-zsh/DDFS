import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/email_service.dart';

class RemoteSupportScreen extends StatelessWidget {
  const RemoteSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmailService emailService = EmailService();

    return Scaffold(
      appBar: AppBar(title: const Text("Remote Support")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("A support assistant will join shortly."),
            ElevatedButton(
              onPressed: () {
                emailService.sendEmail(
                    "support@ddfs.com",
                    "Remote Support Requested",
                    "User requested remote support."
                );
                Get.snackbar("Request Sent", "Support team will contact you.");
              },
              child: const Text("Request Support"),
            ),
          ],
        ),
      ),
    );
  }
}