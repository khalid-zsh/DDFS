import 'package:get/get.dart';
import '../models/extraction_model.dart';

class ExtractionService {
  final RxList<ExtractionModel> extractions = <ExtractionModel>[].obs;

  void startExtraction(String deviceId) {
    extractions.add(ExtractionModel(
      deviceId: deviceId,
      status: "In Progress",
      timestamp: DateTime.now(),
    ));
  }

  void completeExtraction(String deviceId) {
    int index = extractions.indexWhere((e) => e.deviceId == deviceId);
    if (index != -1) {
      extractions[index] = ExtractionModel(
        deviceId: deviceId,
        status: "Completed",
        timestamp: DateTime.now(),
      );
    }
  }
}
