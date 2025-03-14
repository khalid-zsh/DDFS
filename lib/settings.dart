import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/settings_controller.dart';
import 'utils/startup_manager.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController settingsController = Get.find<SettingsController>();
  final RxBool autoStartEnabled = StartupManager.isAutoStartEnabled().obs;

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Settings")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "TeamViewer ID"),
            controller: TextEditingController(text: settingsController.settings.value.teamViewerId),
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Zoom Link"),
            controller: TextEditingController(text: settingsController.settings.value.zoomLink),
          ),
          const SizedBox(height: 10),

          Obx(() => SwitchListTile(
            title: const Text("Enable Auto-Start on Windows Boot"),
            value: autoStartEnabled.value,
            onChanged: (bool value) {
              if (value) {
                StartupManager.enableAutoStart();
              } else {
                StartupManager.disableAutoStart();
              }
              autoStartEnabled.value = value;
            },
          )),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              settingsController.update();
              Get.snackbar("Success", "Settings Saved!", backgroundColor: Colors.green);
            },
            child: const Text("Save Settings"),
          ),
        ],
      ),
    );
  }
}
