
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gbfinds/screen/models/UserClass.dart';
import 'package:get/get.dart';

import '../../Vendor/VendorScreen.dart';

class SignupController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();

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

    // Validate inputs
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

    if (password.isEmpty || password.length < 8) {
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
      // Show loading indicator
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      try {
        // Sign up with Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Get the user ID
        String userId = userCredential.user?.uid ?? "";

        // Create a reference to the Realtime Database
        DatabaseReference dbRef = FirebaseDatabase.instance.ref("users/$userId");

        // Get the FCM token if you are using Firebase Cloud Messaging
        String? fcmToken = await FirebaseMessaging.instance.getToken();


        Userclass userclass =  Userclass(name, userId, fcmToken!, phoneNumber, email, password);

        await dbRef.child(userId).set(userclass);


        Get.back();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Signup successful'),
            duration: Duration(seconds: 2),
          ),
        );

        Get.off(() => VendorScreen()); // Replace VendorScreen with your target screen

      } catch (e) {
        // Dismiss the loading indicator
        Get.back();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup failed: ${e.toString()}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
