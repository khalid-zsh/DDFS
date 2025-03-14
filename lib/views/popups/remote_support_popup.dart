import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/email_service.dart';

class RemoteSupportPopup extends StatelessWidget {
  const RemoteSupportPopup({super.key});

  @override
  Widget build(BuildContext context) {
    EmailService.sendEmail(
        "support@ddfs.com",
        "Remote Support Requested",
        "A user has requested remote support. Please join the session."
    );

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(title: Text("Live Support")),
          const SizedBox(height: 10),
          const Text("A support assistant will join shortly...", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/zoom_meeting');
            },
            child: const Text("Join Zoom Meeting"),
          ),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
