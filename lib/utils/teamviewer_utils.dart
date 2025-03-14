import 'dart:math';

class TeamViewerUtils {
  static String generateSessionId() {
    return "TV-${Random().nextInt(900000) + 100000}";
  }

  static String generatePassword() {
    return "${Random().nextInt(9000) + 1000}";
  }
}
