import 'package:flutter/material.dart';
import 'package:gbfinds/screen/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:gbfinds/screen/signUp/controller/SignUpController.dart';

class SignupScreen extends StatelessWidget {
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [



          Positioned.fill(
            child: Image.asset(
              'assets/image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // This helps in aligning widgets to stretch the width of the parent
                children: [
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
                  const SizedBox(height: 36 +40),
                  SizedBox(
                    width: width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        signupController.signUp(context);
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),                  const SizedBox(height: 36 +40),

                  Positioned(
                    bottom: 20,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text("Already Have Account?" ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w900),),TextButton(onPressed: ()=>Get.to(LoginScreen()), child: const Text("Sign In " ,style: TextStyle(fontWeight: FontWeight.w900 ,color: Colors.black),))
                    ],),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
