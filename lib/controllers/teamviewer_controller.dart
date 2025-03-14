import 'package:get/get.dart';
import '../models/teamviewer_model.dart';

class TeamViewerController extends GetxController {
  var session = TeamViewerModel(sessionId: "", password: "", createdAt: DateTime.now()).obs;

  void updateSession(String sessionId, String password) {
    session.value = TeamViewerModel(
      sessionId: sessionId,
      password: password,
      createdAt: DateTime.now(),
    );
    update();
  }
}
