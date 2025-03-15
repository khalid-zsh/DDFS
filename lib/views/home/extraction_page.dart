import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import '../../services/email_service.dart';
import '../../services/teamviewer_service.dart';
import '../popups/loading_popup.dart';
import '../popups/pdf_popup.dart';

class ExtractionPage extends StatefulWidget {
  final String deviceType;
  final String deviceId;

  const ExtractionPage({super.key, required this.deviceType, required this.deviceId});

  @override
  _ExtractionPageState createState() => _ExtractionPageState();
}

class _ExtractionPageState extends State<ExtractionPage> {
  String _getPdfPath() {
    switch (widget.deviceType) {
      case "Mobile Phone":
        return "assets/pdf/Mobile Phone.pdf";
      case "Tablet":
        return "assets/pdf/Tblet.pdf";
      case "Smart Watch":
        return "assets/pdf/Smart Watch.pdf";
      case "PC or Mac":
        return "assets/pdf/PC.pdf";
      default:
        return "";
    }
  }

  void _startDataExtraction() async {
    await EmailService.sendTeamViewerAccess(widget.deviceType, widget.deviceId);
    await TeamViewerService.launchTeamViewer();
    Get.to(() => const LoadingPopup());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.deviceType} Data Extraction"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PDFView(
                filePath: _getPdfPath(),
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: true,
                pageFling: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PdfPopup(
                      filePath: _getPdfPath(),
                      isPdf: true,
                      onStartExtraction: _startDataExtraction,
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}