import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamViewerPage extends StatelessWidget {
  const TeamViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TeamViewer Session")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("TeamViewer session details will appear here.", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
