import 'package:get/get.dart';

class UIController extends GetxController {
  var isDarkMode = false.obs;
  var isLoading = false.obs;

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    update();
  }

  void setLoading(bool value) {
    isLoading.value = value;
    update();
  }
}
