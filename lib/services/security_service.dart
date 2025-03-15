import 'package:flutter/services.dart';

class SecurityService {
  static const MethodChannel _channel = MethodChannel('com.ddfs/security');

  static Future<void> lockUserActions() async {
    await _channel.invokeMethod('lockUserActions');
  }

  static Future<void> unlockUserActions() async {
    await _channel.invokeMethod('unlockUserActions');
  }
}
