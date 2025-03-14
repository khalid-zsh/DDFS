import 'package:get/get.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  void login(String userId, String name, String email, String role) {
    currentUser.value = UserModel(
      userId: userId,
      name: name,
      email: email,
      role: role,
      isAuthenticated: true,
    );
  }

  void logout() {
    currentUser.value = null;
  }

  bool isAdmin() {
    return currentUser.value?.role == "Admin";
  }
}
