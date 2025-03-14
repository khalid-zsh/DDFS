import 'package:get/get.dart';
import '../services/email_service.dart';

class SupportController extends GetxController {
  void requestSupport() {
    EmailService.sendEmail(
        "support@ddfs.com",
        "Remote Support Requested",
        "A user has requested remote support. Please join the session."
    );
  }
}
