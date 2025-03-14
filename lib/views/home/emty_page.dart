import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmtyPage extends StatelessWidget {
  const EmtyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("N/A")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("This page will appear here", style: TextStyle(fontSize: 18)),
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
