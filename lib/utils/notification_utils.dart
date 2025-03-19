import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtils {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize() {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const WindowsInitializationSettings windowsSettings =
    WindowsInitializationSettings(
      appName: 'DDFS',
      appUserModelId: 'com.ddfs.notifications',
      guid: 'df1be389-d99e-4ef8-bc9f-5907923afd0c',
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      windows: windowsSettings,
    );

    notificationsPlugin.initialize(settings);
  }

  static void showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'DDFS',
      'DDFS Notifications',
      importance: Importance.high,
    );

    const WindowsNotificationDetails windowsDetails = WindowsNotificationDetails();

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      windows: windowsDetails,
    );

    await notificationsPlugin.show(0, title, body, details);
  }
}
