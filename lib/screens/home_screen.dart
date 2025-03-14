import 'package:ddfs/screens/Cloud%20Screen/cloud_screen.dart';
import 'package:ddfs/screens/Devices%20Screen/devices_screen.dart';
import 'package:ddfs/screens/Help%20Screen/help_screen.dart';
import 'package:ddfs/screens/Info%20Screen/info_screen.dart';
import 'package:ddfs/screens/Menu%20Screen/menu_screen.dart';
import 'package:ddfs/screens/Message%20Screen/message_screen.dart';
import 'package:ddfs/screens/Notifications%20Screen/notifications_screen.dart';
import 'package:ddfs/screens/Profile%20Screen/profile_screen.dart';
import 'package:ddfs/screens/Warning%20Screen/warning_screen.dart';
import 'package:flutter/material.dart';
import 'data_extraction_screen.dart';
import 'remote_support_screen.dart';
import 'schedule_appointment_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'D D F S   D A T A  E X T R A C T I O N   H U B',
          style: TextStyle(letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[900],
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/Logo/logo.png', height: 30),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MenuScreen()),
                        );
                      },
                      child: Text('Menu', style: TextStyle(color: Colors.white)),
                    ),
                    _divider(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DevicesScreen()),
                        );
                      },
                      child: Text('Devices', style: TextStyle(color: Colors.white)),
                    ),
                    _divider(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsScreen()),
                        );
                      },
                      child: Text('Settings', style: TextStyle(color: Colors.white)),
                    ),
                    _divider(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HelpScreen()),
                        );
                      },
                      child: Text('Help', style: TextStyle(color: Colors.white)),
                    ),
                    _divider(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WarningScreen()),
                        );
                      },
                      child: Icon(Icons.warning, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CloudScreen()),
                        );
                      },
                      child: Icon(Icons.cloud, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationsScreen()),
                        );
                      },
                      child: Icon(Icons.notifications, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InfoScreen()),
                        );
                      },
                      child: Icon(Icons.info, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileScreen()),
                        );
                      },
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsScreen()),
                        );
                      },
                      child: Icon(Icons.settings, color: Colors.white),
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
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(7, (index) => _buildGridItem(context, index)),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'R E M O T E  D A T A  C O L L E C T I O N  U N I T',
                      style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 2),
                    ),
                    SizedBox(height: 5),
                    Text('UNIT ID: DDFS_RDCU_0003', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 5),
                    Text('24/7 CUSTOMER SERVICE 877.471.DDFS', style: TextStyle(color: Colors.white)),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MessageScreen()),
                          );
                        },
                        child: Icon(Icons.messenger, color: Colors.white, size: 30,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              'Copyright © 2025 DDFS. All rights reserved.',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(height: 20, width: 2, color: Colors.white),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    List<Map<String, dynamic>> data = [
      {
        'icon': Icons.phone_iphone,
        'title': 'Mobile Phone Data Extraction',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DataExtractionScreen(deviceType: "Mobile Phone")),
          );
        },
      },
      {
        'icon': Icons.tablet,
        'title': 'Tablet Data Extraction',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DataExtractionScreen(deviceType: "Tablet")),
          );
        },
      },
      {
        'icon': Icons.watch,
        'title': 'Smart Watch Data Extraction',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DataExtractionScreen(deviceType: "Smart Watch")),
          );
        },
      },
      {
        'icon': Icons.laptop,
        'title': 'PC or Mac Data Extraction',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DataExtractionScreen(deviceType: "PC or Mac")),
          );
        },
      },
      {
        'icon': Icons.support,
        'title': 'Remote Support',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RemoteSupportScreen()),
          );
        },
      },
      {
        'icon': Icons.calendar_today,
        'title': 'Schedule an Appointment',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScheduleAppointmentScreen()),
          );
        },
      },
      {
        'icon': Icons.settings,
        'title': 'Settings',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsScreen()),
          );
        },
      },
    ];

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.grey[800],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data[index]['icon'], color: Colors.white, size: 40),
          SizedBox(height: 10),
          Text(
            data[index]['title'],
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          OutlinedButton(
            onPressed: data[index]['onPressed'],
            style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.blue)),
            child: Text('Get Started', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}