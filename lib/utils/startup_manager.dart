import 'dart:io';
import 'package:path/path.dart' as path;

class StartupManager {
  static String getStartupPath() {
    return path.join(
      Platform.environment['APPDATA']!,
      r'Microsoft\Windows\Start Menu\Programs\Startup\DDFS.lnk',
    );
  }

  static void enableAutoStart() {
    String appPath = Platform.resolvedExecutable;
    String startupPath = getStartupPath();

    final shortcut = '''
    [InternetShortcut]
    URL=file:///$appPath
    IconIndex=0
    ''';

    File(startupPath).writeAsStringSync(shortcut);
    print("Auto-start enabled.");
  }

  static void disableAutoStart() {
    String startupPath = getStartupPath();
    if (File(startupPath).existsSync()) {
      File(startupPath).deleteSync();
      print("Auto-start disabled.");
    }
  }

  static bool isAutoStartEnabled() {
    return File(getStartupPath()).existsSync();
  }
}
