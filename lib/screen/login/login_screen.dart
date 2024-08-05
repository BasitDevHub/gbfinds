import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbfinds/screen/signUp/signup_screen.dart';
import 'package:get/get.dart';

import 'login_controller/LoginController.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Image covering the entire screen
          SizedBox.expand(
            child: Image.asset(
              'assets/image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Positioned widgets on top of the image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onChanged: _loginController.validateEmail,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    onChanged: _loginController.validatePassword,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 32.0),
                  SizedBox(
                    width: width * 0.7,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: _loginController.login,
                      child: const Text('Login',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold ,color: Colors.black),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 100,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Or'),
                ),
                Expanded(
                  child: Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(child: TextButton(onPressed: (){Get.to(SignupScreen());},child: const Text('Create an Account' ,style: TextStyle(color: Colors.white ,fontSize: 18 ),),),

          bottom: 60,
          left: 10,right: 10,)
        ],
      ),
    );
  }
}
