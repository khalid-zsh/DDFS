import 'package:ddfs/services/settings_password_protection.dart';
import 'package:get/get.dart';
import '../views/home/home_page.dart';
import '../views/home/help_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomeScreen()),
    GetPage(name: '/settings', page: () => SettingsPasswordProtection()),
    GetPage(name: '/help', page: () => const HelpPage()),
  ];
}