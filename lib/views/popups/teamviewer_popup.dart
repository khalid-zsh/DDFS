import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TeamViewerPopup extends StatelessWidget {
  final String sessionId;
  final String password;

  const TeamViewerPopup({super.key, required this.sessionId, required this.password});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("TeamViewer Session Details", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            _copyableText("Session ID: $sessionId"),
            _copyableText("Password: $password"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _copyableText(String text) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text("Copied to clipboard")));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
