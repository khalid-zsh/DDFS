import 'dart:io';

class PermissionsHelper {
  static bool isAdmin() {
    return Platform.environment.containsKey('USERNAME') && Platform.environment['USERNAME'] == 'Administrator';
  }
}
