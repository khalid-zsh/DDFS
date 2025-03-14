import 'package:flutter/services.dart';

class TeamViewerService {
  static const MethodChannel _channel = MethodChannel('com.ddfs/teamviewer');

  static Future<void> launchTeamViewer() async {
    try {
      await _channel.invokeMethod('launchTeamViewer');
    } catch (e) {
      print("Error launching TeamViewer: $e");
    }
  }
}
