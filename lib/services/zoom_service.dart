import 'package:flutter/services.dart';

class ZoomService {
  static const MethodChannel _channel = MethodChannel('com.ddfs/zoom');

  static Future<void> launchZoom() async {
    try {
      await _channel.invokeMethod('launchZoom');
    } catch (e) {
      print("Error launching Zoom: $e");
    }
  }
}
