import 'package:flutter/services.dart';

class DeviceService {
  static const MethodChannel _channel = MethodChannel('com.ddfs/usb');

  static Future<List<Map<String, String>>> getConnectedDevices() async {
    try {
      final List<dynamic> devices = await _channel.invokeMethod('getUSBDevices');

      return devices.map((device) {
        return {
          'name': device.toString(), // Convert to String
          'type': 'Unknown', // Default type
          'status': 'Connected', // Default status
        };
      }).toList();
    } catch (e) {
      print("Error detecting USB devices: $e");
      return [];
    }
  }
}
