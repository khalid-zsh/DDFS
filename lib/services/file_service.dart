import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileService {
  static Future<void> copyFile(String sourceFilePath, String destinationDir) async {
    final fileName = path.basename(sourceFilePath);
    final destinationFilePath = path.join(destinationDir, fileName);
    final sourceFile = File(sourceFilePath);

    await sourceFile.copy(destinationFilePath);
  }

  static Future<void> copyFilesFromUSB(String usbPath, String destinationDir) async {
    final usbDir = Directory(usbPath);
    final destDir = Directory(destinationDir);

    if (!await usbDir.exists()) {
      Get.snackbar("Error", "USB storage not found!", backgroundColor: Colors.red);
      return;
    }

    if (!await destDir.exists()) {
      await destDir.create(recursive: true);
    }

    try {
      await for (var entity in usbDir.list(recursive: true, followLinks: false)) {
        if (entity is File) {
          final relativePath = path.relative(entity.path, from: usbPath);
          final newPath = path.join(destinationDir, relativePath);
          await entity.copy(newPath);
        }
      }
      Get.snackbar("Success", "Data copied successfully!", backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Error", "Failed to copy data: $e", backgroundColor: Colors.red);
    }
  }
}