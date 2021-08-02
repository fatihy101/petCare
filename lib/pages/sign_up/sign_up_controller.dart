import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/services/authentication.dart';
import 'package:pet_care/services/user_service.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nameSurnameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController passwordReCtrl = TextEditingController();
  Authentication _authentication = Get.find();

  Future<bool> submit() async {
    if (formKey.currentState!.validate()) {
      var emailText = emailCtrl.text.trim();
      await _authentication.signUpEmailPass(
          emailText, passwordCtrl.text.toString());
      if (_authentication.isUserSignedIn.value != false) {
        await UserService.saveUserInformation(emailText, nameSurnameCtrl.text);
        return true;
      }
      return false;
    }
    return false;
  }
}
