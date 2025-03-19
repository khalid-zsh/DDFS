import 'package:flutter/services.dart';

class NativeMethods {
  static const platform = MethodChannel('com.yourapp/nativeMethods');

  static Future<void> blockAltF4() async {
    try {
      await platform.invokeMethod('blockAltF4');
    } on PlatformException catch (e) {
      print("Failed to block Alt+F4: '${e.message}'.");
    }
  }

  static Future<void> blockEscKey() async {
    try {
      await platform.invokeMethod('blockEscKey');
    } on PlatformException catch (e) {
      print("Failed to block Esc key: '${e.message}'.");
    }
  }

  static Future<void> blockWindowsKey() async {
    try {
      await platform.invokeMethod('blockWindowsKey');
    } on PlatformException catch (e) {
      print("Failed to block Windows key: '${e.message}'.");
    }
  }

  static Future<void> blockWinR() async {
    try {
      await platform.invokeMethod('blockWinR');
    } on PlatformException catch (e) {
      print("Failed to block Win+R: '${e.message}'.");
    }
  }

  static Future<void> hideTaskbar() async {
    try {
      await platform.invokeMethod('hideTaskbar');
    } on PlatformException catch (e) {
      print("Failed to hide taskbar: '${e.message}'.");
    }
  }
}