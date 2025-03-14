import 'package:get/get.dart';

class NotificationService {
  var notifications = <String>[].obs;

  void addNotification(String message) {
    notifications.add(message);
  }

  void clearNotifications() {
    notifications.clear();
  }
}
