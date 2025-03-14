import 'package:flutter/material.dart';

class RemoteSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remote Support'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Code to send an alert via email/SMS/chat app
              },
              child: Text('Send Alert'),
            ),
            ElevatedButton(
              onPressed: () {
                // Code to start a chat with support
              },
              child: Text('Chat with Support'),
            ),
            ElevatedButton(
              onPressed: () {
                // Code to start a Zoom meeting
              },
              child: Text('Start Zoom Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}