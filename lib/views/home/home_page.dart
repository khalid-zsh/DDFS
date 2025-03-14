import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/teamviewer_service.dart';
import '../../services/zoom_service.dart';
import '../../services/device_service.dart';
import '../home/device_list_page.dart';
import '../home/extraction_page.dart';
import '../home/logs_page.dart';
import '../home/settings_page.dart';
import '../home/help_page.dart';
import '../home/teamviewer_page.dart';
import '../home/calendly_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> connectedDevices = [];

  @override
  void initState() {
    super.initState();
    _fetchConnectedDevices();
  }

  void _fetchConnectedDevices() async {
    List<String> devices = await DeviceService.getConnectedDevices();
    setState(() {
      connectedDevices = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'D D F S   D A T A  E X T R A C T I O N   H U B',
          style: TextStyle(letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[900],
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/Logo/logo.png', height: 30),
                    const SizedBox(width: 20),
                    _menuItem("Menu", () => Get.to(() => const DeviceListPage())),
                    _divider(),
                    _menuItem("Devices", () => Get.to(() => const DeviceListPage())),
                    _divider(),
                    _menuItem("Settings", () => Get.to(() => const SettingsPage())),
                    _divider(),
                    _menuItem("Help", () => Get.to(() => const HelpPage())),
                    _divider(),
                    GestureDetector(
                      onTap: () => Get.to(() => const LogsPage()),
                      child: const Icon(Icons.warning, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => const TeamViewerPage()),
                      child: const Icon(Icons.cloud, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.to(() => const LogsPage()),
                      child: const Icon(Icons.notifications, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.to(() => const HelpPage()),
                      child: const Icon(Icons.info, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.to(() => const SettingsPage()),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.to(() => const SettingsPage()),
                      child: const Icon(Icons.settings, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.grey[850],
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(6, (index) => _buildGridItem(context, index)),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'R E M O T E  D A T A  C O L L E C T I O N  U N I T',
                      style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 2),
                    ),
                    const SizedBox(height: 5),
                    const Text('UNIT ID: DDFS_RDCU_0003', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 5),
                    const Text('24/7 CUSTOMER SERVICE 877.471.DDFS', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 20),

                    // New TeamViewer & Zoom Buttons
                    ElevatedButton(
                      onPressed: () => TeamViewerService.launchTeamViewer(),
                      child: const Text("Launch TeamViewer"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => ZoomService.launchZoom(),
                      child: const Text("Join Zoom Meeting"),
                    ),

                    const SizedBox(height: 20),
                    const Text("Connected USB Devices:", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ...connectedDevices.map((device) => Text(device, style: const TextStyle(color: Colors.white))),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _fetchConnectedDevices,
                      child: const Text("Refresh Devices"),
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () => Get.to(() => const HelpPage()),
                        child: const Icon(Icons.messenger, color: Colors.white, size: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: const Text(
              'Copyright © 2025 DDFS. All rights reserved.',
              style: TextStyle(color: Colors.white),
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
      child: Text(title, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    List<Map<String, dynamic>> data = [
      {'icon': Icons.phone_iphone, 'title': 'Mobile Data Extraction', 'page': ExtractionPage(deviceType: "Mobile Phone")},
      {'icon': Icons.tablet, 'title': 'Tablet Data Extraction', 'page': ExtractionPage(deviceType: "Tablet")},
      {'icon': Icons.watch, 'title': 'Smart Watch Data Extraction', 'page': ExtractionPage(deviceType: "Smart Watch")},
      {'icon': Icons.laptop, 'title': 'PC or Mac Data Extraction', 'page': ExtractionPage(deviceType: "PC or Mac")},
      {'icon': Icons.support, 'title': 'Remote Support', 'page': const HelpPage()},
      {'icon': Icons.calendar_today, 'title': 'Schedule an Appointment', 'page': const CalendlyPage()},
    ];

    return GestureDetector(
      onTap: () => Get.to(() => data[index]['page']),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.white), color: Colors.grey[800]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data[index]['icon'], color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(data[index]['title'], textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Get.to(() => data[index]['page']),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.blue)),
              child: const Text('Get Started', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
