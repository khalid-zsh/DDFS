import 'package:ddfs/services/email_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ddfs/controllers/settings_controller.dart';
import 'utils/platform_utils.dart';
import 'utils/startup_manager.dart';
import 'utils/notification_utils.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup full-screen mode
  PlatformUtils.disableCloseButton();
  PlatformUtils.setFullScreen();
  // Enable auto-start at Windows boot
  StartupManager.enableAutoStart();

  // Initialize local notifications
  NotificationUtils.initialize();

  // Use permanent instance to avoid multiple creations
  Get.put(SettingsController(), permanent: true);
  Get.lazyPut(() => EmailService());

  runApp(const DDFSApp());
  debugPrint("Flutter App Started Successfully");
}