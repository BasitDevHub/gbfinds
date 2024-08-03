import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'login_controller/LoginController.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children:[

            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onChanged: _loginController.validateEmail,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      errorText: _loginController.isEmailValid.value ? null : 'Invalid email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    onChanged: _loginController.validatePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      errorText: _loginController.isPasswordValid.value ? null : 'Password is required',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _loginController.login,
                    child: Text('Login'),
                  ),
                ],
              );
            }),
          ),
          ]


        ),
      ),
    );
  }
}