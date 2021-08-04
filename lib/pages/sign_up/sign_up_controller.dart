import 'dart:convert';

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
  UserService _userService = Get.find();
  RxString selectedAvatar = "".obs;
  RxList<Widget> animalAvatars = List<Widget>.empty(growable: true).obs;

  static const imageDir = "images/animal_illustrations/";

  @override
  void onInit() {
    super.onInit();
    selectedAvatar.value = imageDir + "bichon.jpg";
  }

  Future<bool> submitEmailPass() async {
    if (formKey.currentState!.validate()) {
      var emailText = emailCtrl.text.trim();
      var user = await _authentication.signUpEmailPass(
          emailText, passwordCtrl.text.toString());
      if (user != null) {
        await _userService.saveToStoreUser(
            emailText, nameSurnameCtrl.text, selectedAvatar.value, user.uid);
        return true;
      }
      return false;
    }
    return false;
  }

  readPhotosFromAsset(BuildContext context) async {
    animalAvatars.clear();
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final images = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith(imageDir));
    for (var image in images) {
      Widget widget = Padding(
        padding: EdgeInsets.all(8),
        child: GestureDetector(
            onTap: () {
              selectedAvatar.value = image;
              Get.back();
            },
            child: CircleAvatar(backgroundImage: AssetImage(image))),
      );
      animalAvatars.add(widget);
    }
  }

  showAvatars() =>
      Get.dialog(GridView.count(crossAxisCount: 3, children: animalAvatars),
          barrierColor: Get.theme.backgroundColor.withOpacity(0.9));
}
