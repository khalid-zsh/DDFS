import 'dart:io';

class LoggingService {
  static final File _logFile = File('extraction_logs.txt');

  static Future<void> writeLog(String logMessage) async {
    try {
      String logEntry = "${DateTime.now()} - $logMessage\n";
      await _logFile.writeAsString(logEntry, mode: FileMode.append);
      print("Log written: $logEntry");
    } catch (e) {
      print("Error writing log: $e");
    }
  }

  static Future<List<String>> readLogs() async {
    try {
      if (await _logFile.exists()) {
        return await _logFile.readAsLines();
      } else {
        return ["No logs found"];
      }
    } catch (e) {
      return ["Error reading logs: $e"];
    }
  }
}
