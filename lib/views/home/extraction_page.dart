import 'package:ddfs/views/home/home_page2.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:get/get.dart';

class ExtractionPage extends StatefulWidget {
  final String appbarName;

  const ExtractionPage({super.key, required this.appbarName});

  @override
  _ExtractionPageState createState() => _ExtractionPageState();
}

class _ExtractionPageState extends State<ExtractionPage> {
  String _getPdfPath() {
    switch (widget.appbarName) {
      case "Mobile Phone":
        return "assets/pdf/Phone Settings.pdf";
      case "Tablet":
        return "assets/pdf/Tablet Settings.pdf";
      case "PC or Mac":
        return "assets/pdf/Computer Settings.pdf";
      default:
        return "";
    }
  }

  void _startDataExtraction() async {
    // Send Unit ID to admin

    Get.to(() => const HomePage2());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.appbarName} Data Extraction")),
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