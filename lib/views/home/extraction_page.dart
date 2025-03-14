import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExtractionPage extends StatelessWidget {
  final String deviceType;
  const ExtractionPage({super.key, required this.deviceType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$deviceType Data Extraction")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Extracting data from $deviceType...", style: const TextStyle(fontSize: 18)),
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
