import 'package:flutter/services.dart';

class DeviceService {
  static const MethodChannel _channel = MethodChannel('com.ddfs/usb');

  static Future<List<Map<String, String>>> getConnectedDevices() async {
    try {
      final List<dynamic> devices = await _channel.invokeMethod('getUSBDevices');

      if (devices.isEmpty) {
        print("🔴 No USB Devices Found.");
        return [];
      }

      print("✅ Detected Devices: $devices");

      return devices.map((device) {
        final Map<String, dynamic> deviceMap = Map<String, dynamic>.from(device);
        return {
          'name': deviceMap['name'] as String? ?? 'Unknown',
          'type': deviceMap['type'] as String? ?? 'Unknown',
          'status': 'Connected',
        };
      }).toList();
    } catch (e) {
      print("❌ Error detecting USB devices: $e");
      return [];
    }
  }
}
