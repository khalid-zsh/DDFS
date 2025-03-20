import 'package:ddfs/services/appointment_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarService _calendarService = CalendarService();
  late Future<List<dynamic>> _events;

  @override
  void initState() {
    super.initState();
    _events = _calendarService.fetchEventTypes();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendly Events"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No events found"));
          }

          final events = snapshot.data!;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                child: ListTile(
                  title: Text(event['name']),
                  subtitle: Text(event['scheduling_url']),
                  trailing: IconButton(
                    icon: Icon(Icons.launch),
                    onPressed: () => _launchURL(event['scheduling_url']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
