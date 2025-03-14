import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExtractionDonePopup extends StatelessWidget {
  const ExtractionDonePopup({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => Get.back()); // Auto-close after 3 sec

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.check_circle, color: Colors.green, size: 40),
          const SizedBox(height: 10),
          const Text("Data Extraction Completed", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
