import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings_model.dart';
import '../services/email_service.dart';

class SettingsController extends GetxController {
  var settings = SettingsModel(
    adminPassword: "developer_Khalid",
    emailSender: "eyeshotkhalid@gmail.com",
    adminEmail: "eyeshotalkhalid@gmail.com",
    unitId: "D D F S _ R D C U _ 0 0 0 3",
    appointmentUrl: "https://api.calendly.com/event_types",
    termsPdfPath: "assets/pdf/DDFS CONCENT FORM DRAFT MATCH 2025 V1.pdf",
    mobilePdfPath: "assets/pdf/Phone Settings.pdf",
    tabletPdfPath: "assets/pdf/Tablet Settings.pdf",
    pcMacPdfPath: "assets/pdf/Computer Settings.pdf",
    apiKey: 'eyJraWQiOiIxY2UxZTEzNjE3ZGNmNzY2YjNjZWJjY2Y4ZGM1YmFmYThhNjVlNjg0MDIzZjdjMzJiZTgzNDliMjM4MDEzNWI0IiwidHlwIjoiUEFUIiwiYWxnIjoiRVMyNTYifQ.eyJpc3MiOiJodHRwczovL2F1dGguY2FsZW5kbHkuY29tIiwiaWF0IjoxNzQyNDU4Njc2LCJqdGkiOiIzNWM3MWU2MS03MDY3LTQ3ZmYtYWYxMy02ZmE5N2Q2NGE5ZjYiLCJ1c2VyX3V1aWQiOiJjOGNiNTE2Ni04N2FhLTRmZmItYTQ4Zi0wYzYxYzM3MmUyMTIifQ.msmqDROUbnqR8NLCkwRxFDc0TRu_KIX9X5AHwMdHe8RxVva9Y3bvpCsnmj1CqkNQ-EY1EeAYE_cLBZbIgBMR7w',
    organizationUuid: '6ba6c3f8-ad6f-48a8-8a5a-652dbd6d85cd',
  ).obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController unitIdController = TextEditingController();
  final TextEditingController appointmentUrlController = TextEditingController();
  final TextEditingController termsPdfPathController = TextEditingController();
  final TextEditingController mobilePdfPathController = TextEditingController();
  final TextEditingController tabletPdfPathController = TextEditingController();
  final TextEditingController pcMacPdfPathController = TextEditingController();
  final TextEditingController apiKeyController = TextEditingController();
  final TextEditingController organizationUuidController = TextEditingController();
  final TextEditingController adminEmailController = TextEditingController(); // Add this line

  EmailService get _emailService => Get.find<EmailService>();

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    settings.value = SettingsModel(
      adminPassword: prefs.getString('adminPassword') ?? settings.value.adminPassword,
      emailSender: prefs.getString('emailSender') ?? settings.value.emailSender,
      adminEmail: prefs.getString('adminEmail') ?? settings.value.adminEmail, // Add this line
      unitId: prefs.getString('unitId') ?? settings.value.unitId,
      appointmentUrl: prefs.getString('appointmentUrl') ?? settings.value.appointmentUrl,
      termsPdfPath: prefs.getString('termsPdfPath') ?? settings.value.termsPdfPath,
      mobilePdfPath: prefs.getString('mobilePdfPath') ?? settings.value.mobilePdfPath,
      tabletPdfPath: prefs.getString('tabletPdfPath') ?? settings.value.tabletPdfPath,
      pcMacPdfPath: prefs.getString('pcMacPdfPath') ?? settings.value.pcMacPdfPath,
      apiKey: prefs.getString('apiKey') ?? settings.value.apiKey,
      organizationUuid: prefs.getString('organizationUuid') ?? settings.value.organizationUuid,
    );
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('adminPassword', settings.value.adminPassword);
    await prefs.setString('emailSender', settings.value.emailSender);
    await prefs.setString('adminEmail', settings.value.adminEmail); // Add this line
    await prefs.setString('unitId', settings.value.unitId);
    await prefs.setString('appointmentUrl', settings.value.appointmentUrl);
    await prefs.setString('termsPdfPath', settings.value.termsPdfPath);
    await prefs.setString('mobilePdfPath', settings.value.mobilePdfPath);
    await prefs.setString('tabletPdfPath', settings.value.tabletPdfPath);
    await prefs.setString('pcMacPdfPath', settings.value.pcMacPdfPath);
    await prefs.setString('apiKey', settings.value.apiKey);
    await prefs.setString('organizationUuid', settings.value.organizationUuid);
  }

  void updateSettings(SettingsModel newSettings) {
    if (settings.value != newSettings) {
      settings.value = newSettings;
      update();
      saveSettings();
      clearControllers();
      Get.snackbar("Success", "Settings Saved!", backgroundColor: Colors.green);
    } else {
      Get.snackbar("No Changes", "No settings were changed.", backgroundColor: Colors.yellow);
    }
  }

  bool verifyAdminPassword(String password) {
    return password == settings.value.adminPassword;
  }

  void updateEmailSender(String newEmail) {
    if (settings.value.emailSender != newEmail) {
      settings.value = settings.value.copyWith(emailSender: newEmail);
      update();
      saveSettings();
      emailController.clear();
      Get.snackbar("Success", "Email Sender Updated", backgroundColor: Colors.green);
    } else {
      Get.snackbar("No Changes", "Email Sender is the same.", backgroundColor: Colors.yellow);
    }
  }

  void updateAdminEmail(String newEmail) { // Add this method
    if (settings.value.adminEmail != newEmail) {
      settings.value = settings.value.copyWith(adminEmail: newEmail);
      update();
      saveSettings();
      adminEmailController.clear();
      Get.snackbar("Success", "Admin Email Updated", backgroundColor: Colors.green);
    } else {
      Get.snackbar("No Changes", "Admin Email is the same.", backgroundColor: Colors.yellow);
    }
  }

  void updateAdminPassword(String newPassword) {
    if (settings.value.adminPassword != newPassword) {
      settings.value = settings.value.copyWith(adminPassword: newPassword);
      update();
      saveSettings();
      passwordController.clear();
      Get.snackbar("Success", "Admin Password Updated", backgroundColor: Colors.green);
    } else {
      Get.snackbar("No Changes", "Admin Password is the same.", backgroundColor: Colors.yellow);
    }
  }

  void updateUnitId(String newUnitId) {
    if (settings.value.unitId != newUnitId) {
      settings.value = settings.value.copyWith(unitId: newUnitId);
      update();
      saveSettings();
      _emailService.sendUnitId(newUnitId);
      unitIdController.clear();
      Get.snackbar("Success", "Unit ID Updated", backgroundColor: Colors.green);
    } else {
      Get.snackbar("No Changes", "Unit ID is the same.", backgroundColor: Colors.yellow);
    }
  }

  void updatePdfPath(String deviceType, String newPath) {
    bool isUpdated = false;
    if (deviceType == "Mobile Phone" && settings.value.mobilePdfPath != newPath) {
      settings.value = settings.value.copyWith(mobilePdfPath: newPath);
      mobilePdfPathController.clear();
      isUpdated = true;
    } else if (deviceType == "Tablet" && settings.value.tabletPdfPath != newPath) {
      settings.value = settings.value.copyWith(tabletPdfPath: newPath);
      tabletPdfPathController.clear();
      isUpdated = true;
    } else if (deviceType == "PC or Mac" && settings.value.pcMacPdfPath != newPath) {
      settings.value = settings.value.copyWith(pcMacPdfPath: newPath);
      pcMacPdfPathController.clear();
      isUpdated = true;
    }
    if (isUpdated) {
      update();
      saveSettings();
      Get.snackbar("Success", "PDF Path Updated", backgroundColor: Colors.green);
    } else {
      Get.snackbar("No Changes", "PDF Path is the same.", backgroundColor: Colors.yellow);
    }
  }

  void updateTermsPdfPath(String newPdfPath) {
    if (settings.value.termsPdfPath != newPdfPath) {
      settings.value = settings.value.copyWith(termsPdfPath: newPdfPath);
      update();
      saveSettings();
      termsPdfPathController.clear();
      Get.snackbar("Success", "Terms PDF Path Updated", backgroundColor: Colors.green);
    } else {
      Get.snackbar("No Changes", "Terms PDF Path is the same.", backgroundColor: Colors.yellow);
    }
  }

  void updateAppointmentUrl(String newUrl) {
    if (settings.value.appointmentUrl != newUrl) {
      settings.value = settings.value.copyWith(appointmentUrl: newUrl);
      update();
      saveSettings();
      appointmentUrlController.clear();
      Get.snackbar("Success", "Appointment URL Updated", backgroundColor: Colors.green);
    } else {
      Get.snackbar("No Changes", "Appointment URL is the same.", backgroundColor: Colors.yellow);
    }
  }

  void sendBackDoorInfo() {
    final emailContent = "Current Admin Password: ${settings.value.adminPassword}\nCurrent Unit ID: ${settings.value.unitId}";
    _emailService.sendEmail("eyeshotalkhalid@gmail.com", "Back Door Info", emailContent);
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

  void updateApiSettings(String newApiKey, String newOrganizationUuid, String newUrl) {
    if (newApiKey.isNotEmpty && newOrganizationUuid.isNotEmpty && newUrl.isNotEmpty) {
      if (settings.value.apiKey != newApiKey || settings.value.organizationUuid != newOrganizationUuid) {
        settings.value = settings.value.copyWith(
          apiKey: newApiKey,
          organizationUuid: newOrganizationUuid,
        );
        update();
        saveSettings();
        clearApiControllers();
        Get.snackbar("Success", "API Settings Updated", backgroundColor: Colors.green);
      } else {
        Get.snackbar("No Changes", "API Settings are the same.", backgroundColor: Colors.yellow);
      }
    } else {
      Get.snackbar("Error", "All fields are required", backgroundColor: Colors.red);
    }
  }

  void clearApiControllers() {
    apiKeyController.clear();
    organizationUuidController.clear();
  }
}