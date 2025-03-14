import 'package:get/get.dart';
import '../models/log_model.dart';

class LogController extends GetxController {
  var logs = <LogModel>[].obs;

  void addLog(String action) {
    logs.add(LogModel(
      logId: DateTime.now().millisecondsSinceEpoch.toString(),
      action: action,
      timestamp: DateTime.now(),
    ));
    update();
  }
}
