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

      print("✅ Detected Devices: $devices"); // Debugging output

      return devices.map((device) {
        final String deviceName = _getDeviceName(device.toString());
        final String deviceType = _getDeviceType(deviceName);
        return {
          'name': deviceName,
          'type': deviceType,
          'status': 'Connected',
        };
      }).toList();
    } catch (e) {
      print("❌ Error detecting USB devices: $e");
      return [];
    }
  }

  static String _getDeviceName(String deviceId) {
    // Add your own mapping of USB IDs to device names here
    Map<String, String> deviceNames = {
      'USB\\VID_05E3&PID_0608': 'USB Hub',
      'USB\\VID_1A2C&PID_9EF4': 'Keyboard',
      'USB\\VID_4E53&PID_5406': 'Mouse',
      // Add more mappings as needed
    };

    for (var key in deviceNames.keys) {
      if (deviceId.contains(key)) {
        return deviceNames[key]!;
      }
    }
    return 'Unknown Device';
  }

  static String _getDeviceType(String deviceName) {
    if (deviceName.toLowerCase().contains('keyboard')) {
      return 'Keyboard';
    } else if (deviceName.toLowerCase().contains('mouse')) {
      return 'Mouse';
    } else if (deviceName.toLowerCase().contains('hub')) {
      return 'Hub';
    } else {
      return 'Unknown';
    }
  }
}