import 'package:gbfinds/screen/Vendor/VendorScreen.dart';
import 'package:gbfinds/screen/dashboard/dashboarb_screen.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Observables for email and password
  var email = ''.obs;
  var password = ''.obs;

  // Validation
  var isEmailValid = false.obs;
  var isPasswordValid = false.obs;

  void validateEmail(String value) {
    isEmailValid.value = value.isNotEmpty && GetUtils.isEmail(value);
    email.value = value;
  }

  void validatePassword(String value) {
    isPasswordValid.value = value.isNotEmpty;
    password.value = value;
  }

  void login() {
    if (isEmailValid.value && isPasswordValid.value) {
      // Handle login logic here
      Get.snackbar('Login', 'Logging in with ${email.value}');

      Get.to(() =>VendorScreen());
    } else {
      Get.snackbar('Login Error', 'Please enter valid email and password');
    }
  }
}
