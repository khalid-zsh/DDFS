import 'dart:io';

class Logger {
  static void log(String message) {
    final logFile = File("logs.txt");
    logFile.writeAsStringSync("${DateTime.now()} - $message\n", mode: FileMode.append);
    print(message);
  }
}
