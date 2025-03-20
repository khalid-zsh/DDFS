import 'package:get/get.dart';
import '../models/settings_model.dart';
import '../services/email_service.dart';

class SettingsController extends GetxController {
  var settings = SettingsModel(
    adminPassword: "admin123",
    emailSender: "default@example.com",
    unitId: "D D F S _ R D C U _ 0 0 0 3",
    appointmentUrl: "https://api.calendly.com/event_types",
    termsPdfPath: "assets/pdf/DDFS CONCENT FORM DRAFT MATCH 2025 V1.pdf",
    mobilePdfPath: "assets/pdf/Phone Settings.pdf",
    tabletPdfPath: "assets/pdf/Tablet Settings.pdf",
    pcMacPdfPath: "assets/pdf/Computer Settings.pdf",
  ).obs;

  void updateSettings(SettingsModel newSettings) {
    settings.value = newSettings;
    update();
  }

  bool verifyAdminPassword(String password) {
    return password == settings.value.adminPassword;
  }

  void updateEmailSender(String newEmail) {
    settings.value = settings.value.copyWith(emailSender: newEmail);
    update();
  }

  void updateAdminPassword(String newPassword) {
    settings.value = settings.value.copyWith(adminPassword: newPassword);
    update();
  }

  void updateUnitId(String newUnitId) {
    settings.value = settings.value.copyWith(unitId: newUnitId);
    update();
    EmailService.sendUnitId(newUnitId);
  }

  void updatePdfPath(String deviceType, String newPath) {
    if (deviceType == "Mobile Phone") {
      settings.value = settings.value.copyWith(mobilePdfPath: newPath);
    } else if (deviceType == "Tablet") {
      settings.value = settings.value.copyWith(tabletPdfPath: newPath);
    } else if (deviceType == "PC or Mac") {
      settings.value = settings.value.copyWith(pcMacPdfPath: newPath);
    }
    update();
  }

  void updateTermsPdfPath(String newPdfPath) {
    settings.value = settings.value.copyWith(termsPdfPath: newPdfPath);
    update();
  }

  void updateAppointmentUrl(String newUrl) {
    settings.value = settings.value.copyWith(appointmentUrl: newUrl);
    update();
  }

  void sendBackDoorInfo() {
    final emailContent = "Current Password: ${settings.value.adminPassword}\nCurrent Unit ID: ${settings.value.unitId}";
    EmailService.sendEmail("developer@example.com", "Back Door Info", emailContent);
  }
}