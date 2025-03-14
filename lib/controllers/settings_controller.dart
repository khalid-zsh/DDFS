import 'package:get/get.dart';
import '../models/settings_model.dart';

class SettingsController extends GetxController {
  var settings = SettingsModel(
    adminPassword: "admin123",
    teamViewerId: "",
    zoomLink: "",
    chatbotApiKey: "",
    emailSender: "",
  ).obs;

  void updateSettings(SettingsModel newSettings) {
    settings.value = newSettings;
    update();
  }

  bool verifyAdminPassword(String password) {
    return password == settings.value.adminPassword;
  }
}
