import 'package:flutter/services.dart';

class DeviceService {
  static const MethodChannel _channel = MethodChannel('com.ddfs/usb');

  static Future<List<String>> getConnectedDevices() async {
    try {
      final List<dynamic> devices = await _channel.invokeMethod('getUSBDevices');

      if (devices.isEmpty) {
        print("🔴 No USB Devices Found.");
        return [];
      }

      print("✅ Detected Devices: $devices"); // Debugging output

      return devices.map((device) {
        return device.toString();  // Convert dynamic to string
      }).toList();
    } catch (e) {
      print("❌ Error detecting USB devices: $e");
      return [];
    }
  }
}