import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/teamviewer_controller.dart';

class TeamViewerScreen extends StatelessWidget {
  final TeamViewerController teamViewerController = Get.find<TeamViewerController>();

  TeamViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TeamViewer Access")),
      body: Obx(() {
        final session = teamViewerController.session.value;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Session ID: ${session.sessionId}"),
            Text("Password: ${session.password}"),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/teamviewer_popup', arguments: session);
              },
              child: const Text("Open Session"),
            ),
          ],
        );
      }),
    );
  }
}
