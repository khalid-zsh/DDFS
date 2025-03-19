import 'package:ddfs/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController _settingsController = Get.find<SettingsController>();

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController(text: _settingsController.settings.value.emailSender);
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController unitIdController = TextEditingController();
    final TextEditingController pdfController1 = TextEditingController();
    final TextEditingController pdfController2 = TextEditingController();
    final TextEditingController pdfController3 = TextEditingController();
    final TextEditingController pdfController4 = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("System Admin Settings")),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text("Admin settings panel", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Change Email"),
            ),
            ElevatedButton(
              onPressed: () {
                _settingsController.updateEmailSender(emailController.text);
                Get.snackbar("Success", "Email Updated", backgroundColor: Colors.green);
              },
              child: const Text("Save Email"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Change Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                if (passwordController.text.length >= 5 && passwordController.text.length <= 9) {
                  _settingsController.updateAdminPassword(passwordController.text);
                  Get.snackbar("Success", "Password Updated", backgroundColor: Colors.green);
                } else {
                  Get.snackbar("Error", "Password must be between 5 and 9 characters", backgroundColor: Colors.red);
                }
              },
              child: const Text("Save Password"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: unitIdController,
              decoration: const InputDecoration(labelText: "Change Unit ID"),
            ),
            ElevatedButton(
              onPressed: () {
                _settingsController.updateUnitId(unitIdController.text);
                Get.snackbar("Success", "Unit ID Updated", backgroundColor: Colors.green);
              },
              child: const Text("Save Unit ID"),
            ),
            const SizedBox(height: 20),
            const Text("Change PDF"),
            TextField(
              controller: pdfController1,
              decoration: const InputDecoration(labelText: "Mobile Data Extraction PDF"),
            ),
            TextField(
              controller: pdfController2,
              decoration: const InputDecoration(labelText: "Tablet Data Extraction PDF"),
            ),
            TextField(
              controller: pdfController3,
              decoration: const InputDecoration(labelText: "Smart Watch Data Extraction PDF"),
            ),
            TextField(
              controller: pdfController4,
              decoration: const InputDecoration(labelText: "PC or Mac Data Extraction PDF"),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement PDF update logic
                Get.snackbar("Success", "PDFs Updated", backgroundColor: Colors.green);
              },
              child: const Text("Save PDFs"),
            ),
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