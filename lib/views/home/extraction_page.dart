import 'package:ddfs/views/home/home_page2.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:get/get.dart';
import 'package:ddfs/controllers/settings_controller.dart';

class ExtractionPage extends StatefulWidget {
  final String appbarName;

  const ExtractionPage({super.key, required this.appbarName});

  @override
  _ExtractionPageState createState() => _ExtractionPageState();
}

class _ExtractionPageState extends State<ExtractionPage> {
  final SettingsController _settingsController = Get.find<SettingsController>();

  String _getPdfPath() {
    switch (widget.appbarName) {
      case "Mobile Phone":
        return _settingsController.settings.value.mobilePdfPath;
      case "Tablet":
        return _settingsController.settings.value.tabletPdfPath;
      case "PC or Mac":
        return _settingsController.settings.value.pcMacPdfPath;
      default:
        return "";
    }
  }

  void _startDataExtraction() async {
    // Send current Unit ID to admin
    _settingsController.updateUnitId(_settingsController.settings.value.unitId);

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