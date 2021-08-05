
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/services/authentication.dart';


class SplashScreenController extends GetxController {
  Authentication _authentication = Get.find();

  var loadingText = "Yükleniyor...".obs;

  Future<void> navigate() async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await _authentication.setUserToService().then((value) {
        if (_authentication.err.value) {
          // ToDo make the app offline
          loadingText.value = "Bir hata olustu\nDaha sonra tekrar deneyin.";
        } else {
          Get.offAllNamed("/home");
        }
      });
      });
  }

  @override
  void onInit() {
    super.onInit();
    navigate();
  }
}
