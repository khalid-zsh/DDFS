import 'package:ddfs/controllers/settings_controller.dart';
import 'package:ddfs/services/settings_password_protection.dart';
import 'package:ddfs/views/home/calendly_page.dart';
import 'package:ddfs/views/home/empty_page.dart';
import 'package:ddfs/views/home/extraction_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/device_list_page.dart';
import '../home/logs_page.dart';
import '../home/help_page.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});


  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final SettingsController _settingsController = Get.find<SettingsController>();

  final List<Map<String, dynamic>> service = [
    {'icon': 'assets/icon/7.png', 'title': 'Mobile\nData Extraction', 'page': ExtractionPage(appbarName: "Mobile Phone"), 'termsKey': 'accepted_terms_mobile'},
    {'icon': 'assets/icon/8.png', 'title': 'Tablet\nData Extraction', 'page': ExtractionPage(appbarName: "Tablet"), 'termsKey': 'accepted_terms_tablet'},
    {'icon': 'assets/icon/9.png', 'title': 'PC or Mac\nData Extraction', 'page': ExtractionPage(appbarName: "PC or Mac"), 'termsKey': 'accepted_terms_pc_mac'},
    {'icon': 'assets/icon/10.png', 'title': 'Schedule\nAppointment', 'page': CalendarPage()},
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
      body: Stack(
        children: [
          Column(
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
                        Image.asset('assets/Logo/DDFS Logo 5.png', height: 80),
                        const SizedBox(width: 20),
                        _menuItem("Menu", () => Get.to(() => const EmptyPage())),
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
                          child: Image.asset('assets/icon/1.png', height: 50),
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
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.grey[850],
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'HANG TIGHT WE ARE CURRENTLY WORKING ON THIS DEVICE',
                            style: TextStyle(
                              fontFamily: '',
                              color: Colors.white,
                              fontSize: 30,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text('PLEASE WAIT UNTIL THIS SCREEN DISAPPEARS',
                              style: TextStyle(
                                fontFamily: '',
                                color: Colors.white,
                                fontSize: 20,
                              )),
                          const SizedBox(height: 5),
                          Image.asset('assets/warning/warning_strip.png',),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 80),
                          Column(
                            children: [
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
                              Obx(() => Text('U N I T  I D : ${_settingsController.settings.value.unitId}',
                                  style: TextStyle(
                                    fontFamily: '',
                                    color: Colors.white,
                                    fontSize: 20,
                                  ))),
                              const SizedBox(height: 5),
                              Text('2 4 / 7   C U S T O M E R   S E R V I C E   8 7 7 . 4 7 1 . D D F S',
                                  style: TextStyle(
                                    fontFamily: '',
                                    color: Colors.white,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
}