import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  var nameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var numberError = ''.obs;

  void signUp(BuildContext context) async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String phoneNumber = numberController.text.trim();

    bool isValid = true;

    if (name.isEmpty) {
      nameError.value = 'Please enter a name';
      isValid = false;
    } else {
      nameError.value = '';
    }

    if (email.isEmpty) {
      emailError.value = 'Please enter an email';
      isValid = false;
    } else {
      emailError.value = '';
    }

    if (password.isEmpty || password.length <= 8) {
      passwordError.value = 'Password must be at least 8 characters';
      isValid = false;
    } else {
      passwordError.value = '';
    }

    if (phoneNumber.isEmpty) {
      numberError.value = 'Please enter a number';
      isValid = false;
    } else {
      numberError.value = '';
    }

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
