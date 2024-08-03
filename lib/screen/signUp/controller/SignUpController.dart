import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  var nameError = ''.obs;
  var numberError = ''.obs;
  var emailError = ''.obs;



void signUp(BuildContext context) async{
  String name = nameController.text.trim();
  String email = emailController.text.trim();
  String password = passwordController.text.trim();
  String phoneNumber = numberController.text.trim();


  if(name.isEmpty){
    nameError.value = 'Please enter a name';
  }
  else if( email.isEmpty)
    {

    }
  else if( password.isEmpty && password.length>8)
  {

  }
  else if( phoneNumber.isEmpty )
  {

  }



    return;
}

}
