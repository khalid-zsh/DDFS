import 'package:flutter/services.dart';

class DeviceService {
  static const MethodChannel _channel = MethodChannel('com.ddfs/usb');

  static Future<List<String>> getConnectedDevices() async {
    try {
      final List<dynamic> devices = await _channel.invokeMethod('getUSBDevices');
      return devices.cast<String>();
    } catch (e) {
      print("Error detecting USB devices: $e");
      return [];
    }
  }
}
