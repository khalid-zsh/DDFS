import 'package:ddfs/services/appointment_service.dart';
import 'package:flutter/material.dart';

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
    _events = _calendarService.fetchEventTypes(); // Fetch event types on load
  }

  // 📌 Function to schedule an event when the user clicks "Schedule"
  Future<void> _scheduleEvent(String eventTypeUri) async {
    try {
      await _calendarService.scheduleEvent(
        eventTypeUri: eventTypeUri,
        inviteeEmail: "eyeshotkhalid@gmail.com", // Replace with actual email
        inviteeName: "User-04", // Replace with actual name
        startTime: "2025-03-22T10:00:00.000Z", // Replace with user-selected time
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Event scheduled successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed to schedule event: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendly Events")),
      body: FutureBuilder<List<dynamic>>(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // 🔄 Show loading
          } else if (snapshot.hasError) {
            return Center(child: Text("❌ Error: ${snapshot.error}")); // 🛑 Show error
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("⚠️ No events found")); // 🚫 Show empty state
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
                    icon: Icon(Icons.event_available),
                    onPressed: () => _scheduleEvent(event['uri']), // Schedule event
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
