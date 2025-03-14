import 'dart:io';
import 'package:ddfs/services/file_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:archive/archive_io.dart';
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
  String? targetDevice;
  bool isExtracting = false;
  bool compressData = false;
  List<String> selectedFiles = [];
  final String localStoragePath = "C:/DDFS_Extracted_Data";

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
        targetDevice = devices.length > 1 ? devices[1] : null; // Auto-select the second device if available
      }
    });
  }

  Future<void> _startExtraction() async {
    if (selectedDevice == null) {
      Get.snackbar("Error", "No source device connected for extraction", backgroundColor: Colors.red);
      return;
    }

    if (targetDevice == null) {
      Get.snackbar("Error", "No target device connected for transfer", backgroundColor: Colors.red);
      return;
    }

    if (selectedFiles.isEmpty) {
      Get.snackbar("Error", "No files selected for extraction", backgroundColor: Colors.red);
      return;
    }

    setState(() => isExtracting = true);

    try {
      // ✅ Copy selected files from source device to local storage
      for (var file in selectedFiles) {
        await FileService.copyFile(file, localStoragePath);
      }

      // ✅ Compress data if the option is selected
      if (compressData) {
        await _compressData();
      }

      // ✅ Transfer data to target device
      for (var file in selectedFiles) {
        await FileService.copyFile(file, targetDevice!);
      }

      Get.snackbar("Success", "Data extraction and transfer completed!", backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Error", "Extraction and transfer failed: $e", backgroundColor: Colors.red);
    }

    setState(() => isExtracting = false);
  }

  Future<void> _compressData() async {
    final encoder = ZipFileEncoder();
    encoder.create('$localStoragePath/extracted_data.zip');
    Directory(localStoragePath).listSync().forEach((file) {
      if (file is File) {
        encoder.addFile(file);
      }
    });
    encoder.close();
  }

  Future<void> _selectFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        selectedFiles = result.paths.whereType<String>().toList();
      });
    }
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
            const Text("Select a source device:", style: TextStyle(fontSize: 18)),
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
            const Text("Select a target device:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            connectedDevices.length < 2
                ? const Text("No target device detected.", style: TextStyle(color: Colors.red))
                : DropdownButton<String>(
              value: targetDevice,
              items: connectedDevices.map((device) {
                return DropdownMenuItem(value: device, child: Text(device));
              }).toList(),
              onChanged: (device) => setState(() => targetDevice = device),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectFiles,
              child: const Text("Select Files for Extraction"),
            ),
            const SizedBox(height: 10),
            selectedFiles.isEmpty
                ? const Text("No files selected.")
                : Expanded(
              child: ListView.builder(
                itemCount: selectedFiles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedFiles[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: compressData,
                  onChanged: (value) => setState(() => compressData = value!),
                ),
                const Text("Compress extracted data into a .zip file"),
              ],
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