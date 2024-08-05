import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gbfinds/screen/signUp/controller/SignUpController.dart';

class SignupScreen extends StatelessWidget {
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Padding(
padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Obx(() => TextFormField(
                controller: signupController.nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
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
                  ),                  errorText: signupController.nameError.value.isEmpty
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
                  ),                  errorText: signupController.emailError.value.isEmpty
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
                  ),                  errorText: signupController.passwordError.value.isEmpty
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
                  ),                  errorText: signupController.numberError.value.isEmpty
                      ? null
                      : signupController.numberError.value,
                ),
              )),
              const SizedBox(height: 16),
              SizedBox(
                width: width * 0.9,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    signupController.signUp(context);
                  },
                  child: const Text('Sign Up'),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
