import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var submitEnabled = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  setSubmitOnChange(value) {
    if (emailController.text == "" || passwordController.text == "") submitEnabled.value = false;
    else submitEnabled.value = true;
  }

  submit() {
    if(formKey.currentState!.validate()) {
      print("validation");
    }
  }
}