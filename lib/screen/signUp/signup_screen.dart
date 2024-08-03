import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbfinds/screen/signUp/controller/SignUpController.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {

  SignupController signupController = Get.put(SignupController());
  final SignupController _signupController = Get.put(SignupController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(

        children: [


          TextFormField(
controller:  _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller:  _passwordController,

            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
