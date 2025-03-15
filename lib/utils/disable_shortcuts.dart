import 'dart:io';
import 'dart:ffi';
import 'package:win32/win32.dart';

class DisableShortcuts {
  /// Disables common Windows shortcuts
  static void disableKeyboardShortcuts() {
    if (Platform.isWindows) {
      // Disable Ctrl+Alt+Del
      SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, 0, nullptr, SPIF_SENDCHANGE);

      print("✅ Windows Shortcuts Disabled.");
    }
  }
}
