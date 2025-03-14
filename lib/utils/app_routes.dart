import 'package:get/get.dart';
import '../views/home/home_page.dart';
import '../views/home/settings_page.dart';
import '../views/home/help_page.dart';
import '../views/home/teamviewer_page.dart';
import '../views/popups/pdf_popup.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomeScreen()),
    GetPage(name: '/settings', page: () => const SettingsPage()),
    GetPage(name: '/help', page: () => const HelpPage()),
    GetPage(name: '/teamviewer', page: () => const TeamViewerPage()),
    GetPage(name: '/pdf_popup', page: () => const PdfPopup(filePath: "", isPdf: true)),
  ];
}
