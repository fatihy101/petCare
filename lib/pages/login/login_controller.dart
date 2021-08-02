import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_care/services/authentication.dart';
import 'package:pet_care/widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  Authentication _authentication = Get.find();
  final formKey = GlobalKey<FormState>();
  var submitEnabled = false.obs;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  setSubmitOnChange(value) {
    if (emailCtrl.text == "" || passCtrl.text == "")
      submitEnabled.value = false;
    else
      submitEnabled.value = true;
  }

  submit() async {
    if (formKey.currentState!.validate()) {
      await _authentication.login(emailCtrl.text, passCtrl.text);
      Get.back();
      if(_authentication.isUserSignedIn.value) {
        CustomSnackBar.getSnackBar("Giriş başarılı!", "Yeniden hoşgeldiniz!");
        formKey.currentState!.reset();
      }
      // TODO Get pets of user
    }
  }
}
