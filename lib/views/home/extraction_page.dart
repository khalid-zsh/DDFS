import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:get/get.dart';
import '../../services/email_service.dart';
import '../popups/loading_popup.dart';

class ExtractionPage extends StatefulWidget {
  final String unitId;

  const ExtractionPage({super.key, required this.unitId});

  @override
  _ExtractionPageState createState() => _ExtractionPageState();
}

class _ExtractionPageState extends State<ExtractionPage> {
  String _getPdfPath() {
    switch (widget.unitId) {
      case "Mobile Phone":
        return "assets/pdf/Phone Settings.pdf";
      case "Tablet":
        return "assets/pdf/Tablet Settings.pdf";
      case "Smart Watch":
        return "assets/pdf/Smart Watch Settings.pdf";
      case "PC or Mac":
        return "assets/pdf/Computer Settings.pdf";
      default:
        return "";
    }
  }

  void _startDataExtraction() async {
    // Send Unit ID to admin
    await EmailService.sendUnitId(widget.unitId);

    // Lock the screen with a loading popup
    Get.to(() => const LoadingPopup());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.unitId} Data Extraction")),
      body: Column(
        children: [
          Expanded(
            child: SfPdfViewer.asset(_getPdfPath()),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _startDataExtraction,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text("Start Now", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}