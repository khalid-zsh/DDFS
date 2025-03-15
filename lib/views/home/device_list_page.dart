import 'package:ddfs/controllers/device_controller.dart';
import 'package:ddfs/models/device_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/device_service.dart';

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({super.key});

  @override
  _DeviceListPageState createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
  final DeviceController deviceController = Get.put(DeviceController());

  @override
  void initState() {
    super.initState();
    _fetchConnectedDevices();
  }

  void _fetchConnectedDevices() async {
    List<String> deviceNames = await DeviceService.getConnectedDevices();

    List<Map<String, String>> devices = deviceNames.map((device) {
      return {
        'name': device,
        'type': 'Unknown', // Default type (Update this if needed)
        'status': 'Connected', // Default status
      };
    }).toList();

    List<DeviceModel> deviceModels = [];
    Set<String> existingDeviceNames = deviceController.connectedDevices.map((device) => device.name).toSet();

    for (Map<String, String> device in devices) {
      if (!existingDeviceNames.contains(device['name'])) {
        try {
          // Auto-detect allowed devices
          bool isAllowedDevice = _isAllowedDevice(device['name'] ?? '');

          if (isAllowedDevice) {
            deviceModels.add(DeviceModel(
              id: (deviceController.connectedDevices.length + deviceModels.length + 1).toString(),
              name: device['name'] ?? 'Unknown',
              type: device['type'] ?? 'Unknown',
              status: device['status'] ?? 'Disconnected',
            ));
          }
        } catch (e) {
          print("Error processing device: ${device['name']}, error: $e");
        }
      }
    }

    // Refresh list: Clear old devices and update new ones
    deviceController.connectedDevices.assignAll(deviceModels);
  }

  bool _isAllowedDevice(String deviceName) {
    // Define keywords typically associated with the allowed devices
    List<String> allowedKeywords = [
      'android', 'iphone', 'ipad', 'macbook', 'imac', 'windows', 'linux', 'tablet', 'smartwatch', 'pen drive', 'usb drive'
    ];

    for (String keyword in allowedKeywords) {
      if (deviceName.toLowerCase().contains(keyword)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connected Devices")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Connected USB Devices:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Obx(() {
              if (deviceController.connectedDevices.isEmpty) {
                return const Text("No connected devices found.", style: TextStyle(fontSize: 16));
              }
              return Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Status')),
                      ],
                      rows: deviceController.connectedDevices.map((device) {
                        return DataRow(cells: [
                          DataCell(Text(device.id)),
                          DataCell(Text(device.name)),
                          DataCell(Text(device.type)),
                          DataCell(Text(device.status)),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchConnectedDevices,
              child: const Text("Refresh Devices"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}