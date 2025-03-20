import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Contact with Developer", style: TextStyle(fontSize: 18)),
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
