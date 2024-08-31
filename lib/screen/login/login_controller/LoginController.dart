  // // import 'package:firebase_auth/firebase_auth.dart';
  // // import 'package:firebase_database/firebase_database.dart';
  // // import 'package:flutter/cupertino.dart';
  // // import 'package:flutter/material.dart';
  // // import 'package:gbfinds/screen/Vendor/VendorScreen.dart';
  // // import 'package:gbfinds/screen/dashboard/dashboarb_screen.dart';
  // // import 'package:get/get.dart';
  // //
  // // class LoginController extends GetxController {
  // //
  // //   final emailController = TextEditingController();
  // //   final passwordController = TextEditingController();
  // //   final RxString emailError = ''.obs;
  // //   final RxString passwordError = ''.obs;
  // //
  // //   void validateEmail(String value) {
  // //     if (!GetUtils.isEmail(value)) {
  // //       emailError.value = 'Please enter a valid email';
  // //     } else {
  // //       emailError.value = '';
  // //     }
  // //   }
  // //
  // //   void validatePassword(String value) {
  // //     if (value.isEmpty || value.length < 8) {
  // //       passwordError.value = 'Password must be at least 8 characters';
  // //     } else {
  // //       passwordError.value = '';
  // //     }
  // //   }
  // //
  // //   void login(BuildContext context) async {
  // //     String email = emailController.text.trim();
  // //     String password = passwordController.text.trim();
  // //
  // //     if (email.isEmpty || password.isEmpty) {
  // //       Get.snackbar(
  // //         'Error',
  // //         'Please fill in all fields',
  // //         snackPosition: SnackPosition.BOTTOM,
  // //         backgroundColor: Colors.red,
  // //         colorText: Colors.white,
  // //       );
  // //       return;
  // //     }
  // //
  // //     if (emailError.value.isNotEmpty || passwordError.value.isNotEmpty) {
  // //       return;
  // //     }
  // //
  // //     // Show loading indicator
  // //     Get.dialog(
  // //       Center(child: CircularProgressIndicator()),
  // //       barrierDismissible: false,
  // //     );
  // //
  // //
  // //     try {
  // //       // Get a reference to the database
  // //       DatabaseReference usersRef = FirebaseDatabase.instance.ref("users");
  // //
  // //       // Query the database to find a user with the provided email
  // //       DatabaseEvent event = await usersRef.orderByChild("userEmail").equalTo(email).once();
  // //
  // //       if (event.snapshot.exists) {
  // //         Map<String, dynamic> userData = Map<String, dynamic>.from(event.snapshot.value as Map);
  // //
  // //         String dbPassword = userData.values.first['user'];
  // //
  // //         if (dbPassword == password) {
  // //           // If password matches, log the user in using FirebaseAuth
  // //           await FirebaseAuth.instance.signInWithEmailAndPassword(
  // //             email: email,
  // //             password: password,
  // //           );
  // //
  // //           // Dismiss the loading indicator
  // //           Get.back();
  // //
  // //           // Show success message
  // //           ScaffoldMessenger.of(context).showSnackBar(
  // //             SnackBar(
  // //               content: Text('Login successful'),
  // //               duration: Duration(seconds: 2),
  // //             ),
  // //           );
  // //
  // //           // Navigate to the next screen
  // //           // Replace `VendorScreen` with the appropriate screen
  // //           Get.off(VendorScreen());
  // //
  // //         } else {
  // //           // Password doesn't match
  // //           Get.back();
  // //           ScaffoldMessenger.of(context).showSnackBar(
  // //             SnackBar(
  // //               content: Text('Invalid password'),
  // //               duration: Duration(seconds: 2),
  // //             ),
  // //           );
  // //         }
  // //       } else {
  // //         // No user found with this email
  // //         Get.back();
  // //         ScaffoldMessenger.of(context).showSnackBar(
  // //           SnackBar(
  // //             content: Text('No user found with this email'),
  // //             duration: Duration(seconds: 2),
  // //           ),
  // //         );
  // //       }
  // //     } catch (e) {
  // //     // Dismiss the loading indicator
  // //     Get.back();
  // //
  // //     // Show error message
  // //     ScaffoldMessenger.of(context).showSnackBar(
  // //     SnackBar(
  // //     content: Text(e.toString()),
  // //     duration: Duration(seconds: 2),
  // //     ),
  // //     );
  // //     }
  // //
  //
  //
  //   }
  //   // Observables for email and password
  //   // var email = ''.obs;
  //   // var password = ''.obs;
  //   //
  //   // // Validation
  //   // var isEmailValid = false.obs;
  //   // var isPasswordValid = false.obs;
  //   //
  //   // void validateEmail(String value) {
  //   //   isEmailValid.value = value.isNotEmpty && GetUtils.isEmail(value);
  //   //   email.value = value;
  //   // }
  //   //
  //   // void validatePassword(String value) {
  //   //   isPasswordValid.value = value.isNotEmpty;
  //   //   password.value = value;
  //   // }
  //   //
  //   // void login() {
  //   //   if (isEmailValid.value && isPasswordValid.value) {
  //   //     // Handle login logic here
  //   //     Get.snackbar('Login', 'Logging in with ${email.value}');
  //   //
  //   //     Get.to(() =>VendorScreen());
  //   //   } else {
  //   //     Get.snackbar('Login Error', 'Please enter valid email and password');
  //   //   }
  //   // }
  // }
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_database/firebase_database.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:gbfinds/screen/Vendor/VendorScreen.dart';

  class LoginController extends GetxController {

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final RxString emailError = ''.obs;
    final RxString passwordError = ''.obs;

    void validateEmail(String value) {
      if (!GetUtils.isEmail(value)) {
        emailError.value = 'Please enter a valid email';
      } else {
        emailError.value = '';
      }
    }

    void validatePassword(String value) {
      if (value.isEmpty || value.length < 8) {
        passwordError.value = 'Password must be at least 8 characters';
      } else {
        passwordError.value = '';
      }
    }

    void login(BuildContext context) async {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        Get.snackbar(
          'Error',
          'Please fill in all fields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (emailError.value.isNotEmpty || passwordError.value.isNotEmpty) {
        return;
      }

      // Show loading indicator
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      try {
        // Get a reference to the database
        DatabaseReference usersRef = FirebaseDatabase.instance.ref("users");

        // Query the database to find a user with the provided email
        DatabaseEvent event = await usersRef.orderByChild("userEmail").equalTo(email).once();

        if (event.snapshot.exists) {
          // Email exists in the database
          Map<String, dynamic> usersData = Map<String, dynamic>.from(event.snapshot.value as Map);

          // Dismiss the loading indicator
          Get.back();

          bool passwordMatches = false;
          for (var userId in usersData.keys) {
            Map<String, dynamic> userData = Map<String, dynamic>.from(usersData[userId]);

            if (userData['userPassword'] == password) {



              // If password matches, log the user in using FirebaseAuth
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email,
                password: password,
              );

              passwordMatches = true;
              break;
            }
          }

          if (passwordMatches) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login successful'),
                duration: Duration(seconds: 2),
              ),
            );

            // Navigate to the appropriate screen
            Get.off(() => VendorScreen()); // Adjust based on user type
          } else {
            // Password doesn't match
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Invalid password'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          // No user found with this email
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No user found with this email'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        // Dismiss the loading indicator
        Get.back();

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
