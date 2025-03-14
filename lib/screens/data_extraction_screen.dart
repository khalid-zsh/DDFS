import 'package:flutter/material.dart';
import 'pdf_viewer_screen.dart';

class DataExtractionScreen extends StatelessWidget {
  final String deviceType;

  const DataExtractionScreen({super.key, required this.deviceType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$deviceType Data Extraction'),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PdfViewerScreen(filePath: 'path/to/mobile_phone_data_extraction.pdf')),
                );
              },
              child: Text('Mobile Phone Data Extraction'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PdfViewerScreen(filePath: 'path/to/tablet_data_extraction.pdf')),
                );
              },
              child: Text('Tablet Data Extraction'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PdfViewerScreen(filePath: 'path/to/smart_watch_data_extraction.pdf')),
                );
              },
              child: Text('Smart Watch Data Extraction'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PdfViewerScreen(filePath: 'path/to/pc_mac_data_extraction.pdf')),
                );
              },
              child: Text('PC or MAC Data Extraction'),
            ),
          ],
        ),
      ),
    );
  }
}