import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gbfinds/screen/Vendor/VendorScreen.dart';
import 'package:get/get.dart';
import 'package:gbfinds/screen/login/login_screen.dart';
import 'package:gbfinds/screen/signUp/controller/SignUpController.dart';


class SignupScreen extends StatelessWidget {
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 150),
                    Obx(() => TextFormField(
                      controller: signupController.nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        fillColor: Colors.white,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        errorText: signupController.nameError.value.isEmpty
                            ? null
                            : signupController.nameError.value,
                      ),
                      keyboardType: TextInputType.text,
                    )),
                    const SizedBox(height: 8.0),
                    Obx(() => TextFormField(
                      controller: signupController.emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        fillColor: Colors.white,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        errorText: signupController.emailError.value.isEmpty
                            ? null
                            : signupController.emailError.value,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    )),
                    const SizedBox(height: 8.0),
                    Obx(() => TextFormField(
                      controller: signupController.passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        fillColor: Colors.white,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        errorText: signupController.passwordError.value.isEmpty
                            ? null
                            : signupController.passwordError.value,
                      ),
                      obscureText: true,
                    )),
                    const SizedBox(height: 8.0),


                    Obx(() => TextFormField(
                      controller: signupController.numberController,
                      decoration: InputDecoration(
                        labelText: 'Number',
                        fillColor: Colors.white,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        errorText: signupController.numberError.value.isEmpty
                            ? null
                            : signupController.numberError.value,
                      ),
                      keyboardType: TextInputType.phone,
                    )),


                    const SizedBox(height: 36 + 40),
                    SizedBox(
                      width: width * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (signupController.nameController.text.isEmpty ||
                              signupController.emailController.text.isEmpty ||
                              signupController.passwordController.text.isEmpty ||
                              signupController.numberController.text.isEmpty) {
                            Get.snackbar("Error", "Please fill all fields");
                            return;
                          }

                          try {
                            // Sign up with Firebase Authentication
                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: signupController.emailController.text,
                              password: signupController.passwordController.text,
                            );

                            // Get the user ID
                            String userId = userCredential.user?.uid ?? "";

                            // Create a reference to the Realtime Database
                            DatabaseReference dbRef = FirebaseDatabase.instance.ref("users");
                            String? fcmToken = await  FirebaseMessaging.instance.getToken();

                            // Create a user object
                            Map<String, String> userData = {
                              'userName': signupController.nameController.text,
                              'userEmail': signupController.emailController.text,
                              'userPassword': signupController.passwordController.text,
                              'userNumber': signupController.numberController.text,
                              'userId': userId,
                              'fcmToken': fcmToken! // Optional: if you are using FCM
                            };
                            // Userclass userclass = Userclass(signupController.nameController.text, userId, fcmToken!, signupController.numberController.text, signupController.emailController.text, signupController.passwordController.text);

                            await dbRef.child(userId).set(userData);
                            // Upload user data to the Realtime Database
                            // await dbRef.set(userclass);

                            Get.snackbar("Success", "Signup successful");
                            Get.off(VendorScreen()); // Redirect to login screen
                          } catch (e) {
                            Get.snackbar("Error", e.toString());
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already Have Account?",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        TextButton(
                          onPressed: () => Get.to(LoginScreen()),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
