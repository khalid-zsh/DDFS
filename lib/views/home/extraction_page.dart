import 'dart:io';
import 'package:ddfs/services/log_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/device_service.dart';

class ExtractionPage extends StatefulWidget {
  final String deviceType;

  const ExtractionPage({super.key, required this.deviceType});

  @override
  _ExtractionPageState createState() => _ExtractionPageState();
}

class _ExtractionPageState extends State<ExtractionPage> {
  List<String> connectedDevices = [];
  String? selectedDevice;
  bool isExtracting = false;

  @override
  void initState() {
    super.initState();
    _fetchConnectedDevices();
  }

  void _fetchConnectedDevices() async {
    List<String> devices = await DeviceService.getConnectedDevices();
    setState(() {
      connectedDevices = devices;
      if (devices.isNotEmpty) {
        selectedDevice = devices.first; // Auto-select first device
      }
    });
  }

  Future<void> _startExtraction() async {
    if (selectedDevice == null) {
      Get.snackbar("Error", "No device connected for extraction", backgroundColor: Colors.red);
      return;
    }

    setState(() => isExtracting = true);
    String logMessage;

    try {
      // ✅ Simulate file extraction
      String extractedData = "Extracted data from $selectedDevice (${widget.deviceType})";
      await Future.delayed(const Duration(seconds: 5)); // Simulate time taken

      // ✅ Save extracted data to a file
      File extractionFile = File('extracted_data_${widget.deviceType}.txt');
      await extractionFile.writeAsString(extractedData);

      logMessage = "SUCCESS: Data extracted from $selectedDevice at ${DateTime.now()}";
      LoggingService.writeLog(logMessage); // ✅ No more undefined error
      Get.snackbar("Success", "Data extraction completed!", backgroundColor: Colors.green);
    } catch (e) {
      logMessage = "ERROR: Extraction failed for $selectedDevice at ${DateTime.now()} - $e";
      LoggingService.writeLog(logMessage); // ✅ No more undefined error
      Get.snackbar("Error", "Extraction failed!", backgroundColor: Colors.red);
    }

    setState(() => isExtracting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.deviceType} Extraction')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Select a connected device:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            connectedDevices.isEmpty
                ? const Text("No devices detected.", style: TextStyle(color: Colors.red))
                : DropdownButton<String>(
              value: selectedDevice,
              items: connectedDevices.map((device) {
                return DropdownMenuItem(value: device, child: Text(device));
              }).toList(),
              onChanged: (device) => setState(() => selectedDevice = device),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isExtracting ? null : _startExtraction,
              child: isExtracting ? const CircularProgressIndicator() : const Text("Start Extraction"),
            ),
          ],
        ),
      ),
    );
  }
}
