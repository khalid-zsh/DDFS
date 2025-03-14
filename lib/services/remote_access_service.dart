import 'dart:math';
import '../models/teamviewer_model.dart';

class RemoteAccessService {
  static TeamViewerModel generateTeamViewerSession() {
    String sessionId = "TV-${Random().nextInt(900000) + 100000}";
    String password = "${Random().nextInt(9000) + 1000}";

    return TeamViewerModel(sessionId: sessionId, password: password, createdAt: DateTime.now());
  }
}
