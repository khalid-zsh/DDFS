import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../services/email_service.dart';
import '../../services/teamviewer_service.dart';
import '../popups/loading_popup.dart'; //

class ExtractionPage extends StatefulWidget {
  final String deviceType;
  const ExtractionPage({super.key, required this.deviceType});

  @override
  _ExtractionPageState createState() => _ExtractionPageState();
}

class _ExtractionPageState extends State<ExtractionPage> {
  String _getPdfPath() {
    switch (widget.deviceType) {
      case "Mobile Phone":
        return "assets/pdfs/mobile_extraction.pdf";
      case "Tablet":
        return "assets/pdfs/tablet_extraction.pdf";
      case "Smart Watch":
        return "assets/pdfs/watch_extraction.pdf";
      case "PC or Mac":
        return "assets/pdfs/pc_extraction.pdf";
      default:
        return "assets/pdfs/default_extraction.pdf";
    }
  }

  void _startDataExtraction() async {
    // Send email/notification with TeamViewer credentials
    await EmailService.sendTeamViewerAccess(widget.deviceType);

    // Launch TeamViewer
    await TeamViewerService.launchTeamViewer();

    // Navigate to Full-Screen Pop-up ✅ Ensure class exists
    Get.to(() => const LoadingPopup());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.deviceType} Data Extraction"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PDFView(
              filePath: _getPdfPath(),
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _startDataExtraction,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
