import 'package:get/get.dart';
import '../models/device_model.dart';

class DeviceController extends GetxController {
  var connectedDevices = <DeviceModel>[].obs;

  void addDevice(DeviceModel device) {
    connectedDevices.add(device);
    update();
  }

  void removeDevice(String deviceId) {
    connectedDevices.removeWhere((device) => device.id == deviceId);
    update();
  }
}
