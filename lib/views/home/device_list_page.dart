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
    int idCounter = 1;
    for (Map<String, String> device in devices) {
      try {
        deviceModels.add(DeviceModel(
          id: idCounter.toString(),
          name: device['name'] ?? 'Unknown',
          type: device['type'] ?? 'Unknown',
          status: device['status'] ?? 'Disconnected',
        ));
        idCounter++;
      } catch (e) {
        print("Error processing device: ${device['name']}, error: $e");
      }
    }

    deviceController.connectedDevices.value = deviceModels;
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
