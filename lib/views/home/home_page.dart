import 'package:ddfs/services/settings_password_protection.dart';
import 'package:ddfs/views/home/calendly_page.dart';
import 'package:ddfs/views/home/chatbot_page.dart';
import 'package:ddfs/views/home/emty_page.dart';
import 'package:ddfs/views/home/extraction_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/device_list_page.dart';
import '../home/logs_page.dart';
import '../home/help_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String unitId = "D D F S _ R D C U _ 0 0 0 3"; // Default Unit ID

  final List<Map<String, dynamic>> service = [
    {'icon': 'assets/icon/7.png', 'title': 'Mobile\nData Extraction', 'page': ExtractionPage(unitId: "Mobile Phone")},
    {'icon': 'assets/icon/8.png', 'title': 'Tablet\nData Extraction', 'page': ExtractionPage(unitId: "Tablet")},
    {'icon': 'assets/icon/9.png', 'title': 'PC or Mac\nData Extraction', 'page': ExtractionPage(unitId: "Smart Watch")},
    {'icon': 'assets/icon/10.png', 'title': 'Schedule\nAppointment', 'page': const CalendlyPage()},
    {'icon': 'assets/icon/11.png', 'title': 'Remote\nSupport', 'page': const HelpPage()},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'D D F S   D A T A  E X T R A C T I O N   H U B',
          style: TextStyle(
              fontFamily: 'Font-2',
              letterSpacing: 2,
              fontSize: 26
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[900],
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/Logo/DDFS Logo 5.png', height: 800),
                    const SizedBox(width: 20),
                    _menuItem("Menu", () => Get.to(() => const EmtyPage())),
                    _divider(),
                    _menuItem("Devices", () => Get.to(() => const DeviceListPage())),
                    _divider(),
                    _menuItem("Settings", () => Get.to(() => SettingsPasswordProtection())),
                    _divider(),
                    _menuItem("Help", () => Get.to(() => const HelpPage())),
                    _divider(),
                    GestureDetector(
                      onTap: () => Get.to(() => const LogsPage()),
                      child: Image.asset('assets/icon/6.png', height: 40),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => const LogsPage()),
                      child: Image.asset('assets/icon/1.png', height: 150),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.to(() => const LogsPage()),
                      child: Image.asset('assets/icon/2.png', height: 50),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.to(() => const HelpPage()),
                      child: Image.asset('assets/icon/3.png', height: 50),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.to(() => SettingsPasswordProtection()),
                      child: Image.asset('assets/icon/4.png', height: 50),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.to(() => SettingsPasswordProtection()),
                      child: Image.asset('assets/icon/5.png', height: 50),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.grey[850],
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 80,
                      ),
                      itemCount: service.length,
                      itemBuilder: (context, index) {
                        return _buildServiceCard(context, index);
                      },
                    ),
                    const SizedBox(height: 60),
                    Text(
                      'R E M O T E  D A T A  C O L L E C T I O N  U N I T',
                      style: TextStyle(
                        fontFamily: '',
                        color: Colors.white,
                        fontSize: 30,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('U N I T  I D : $unitId',
                        style: TextStyle(
                          fontFamily: '',
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    const SizedBox(height: 5),
                    Text('2 4 / 7   C U S T O M E R   S E R V I C E   8 7 7 . 4 7 1 . D D F S',
                        style: TextStyle(
                          fontFamily: '',
                          color: Colors.white,
                          fontSize: 20,
                        )),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () => showChatDialog(context),
                        child: Image.asset(
                          'assets/icon/12.png',
                          color: Colors.blueAccent,
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/icon/13.png',
                          color: Colors.blueAccent,
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(2.7),
            alignment: Alignment.center,
            child: Text(
              'Copyright © 2025 DDFS. All rights reserved.',
              style: TextStyle(
                  fontFamily: 'CustomFont',
                  color: Colors.white,
                  fontSize: 6
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(height: 20, width: 2, child: DecoratedBox(decoration: BoxDecoration(color: Colors.white))),
    );
  }

  Widget _menuItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Font-3',
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, int index) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 250, // Set minimum height
        minWidth: 150, // Set minimum width
        maxHeight: 350, // Set maximum height
        maxWidth: 200, // Set maximum width
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54, width: 2),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(service[index]['icon'], height: 100),
          const SizedBox(height: 10),
          Text(
            service[index]['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Font-3',
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () => Get.to(service[index]['page']),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blueAccent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              'Get Started',
              style: TextStyle(
                fontFamily: 'Font-2',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}