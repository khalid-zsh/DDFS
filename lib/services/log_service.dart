import 'dart:io';

class LogService {
  static void addLog(String action) {
    final logFile = File("logs.txt");
    logFile.writeAsStringSync("${DateTime.now()} - $action\n", mode: FileMode.append);
  }
}
