import 'package:ddfs/controllers/settings_controller.dart' as controller;
import 'package:ddfs/views/home/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class SettingsPasswordProtection extends StatefulWidget {
  const SettingsPasswordProtection({super.key});

  @override
  _SettingsPasswordProtectionState createState() => _SettingsPasswordProtectionState();
}

class _SettingsPasswordProtectionState extends State<SettingsPasswordProtection> {
  final TextEditingController _passwordController = TextEditingController();
  final controller.SettingsController _settingsController = Get.find<controller.SettingsController>();

  void _verifyPassword() {
    if (_settingsController.verifyAdminPassword(_passwordController.text)) {
      _passwordController.clear();
      Get.off(() => SettingsPage());
    } else {
      _passwordController.clear();
      Get.snackbar("Error", "Incorrect Password", backgroundColor: Colors.red);
    }
  }

  void _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.controlLeft) &&
          HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.keyB) &&
          HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.keyD)) {
        _settingsController.sendBackDoorInfo();
        Get.snackbar("Success", "Back Door Info Sent", backgroundColor: Colors.green);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Enter Password")),
      body: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: _handleKeyPress,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Please enter the admin password to access settings."),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _verifyPassword,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}