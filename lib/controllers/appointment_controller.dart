import 'package:get/get.dart';

class AppointmentController extends GetxController {
  var calendlyLink = "https://calendly.com/your-link".obs;

  void updateCalendlyLink(String newLink) {
    calendlyLink.value = newLink;
    update();
  }
}
