import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/services/authentication.dart';
import 'package:pet_care/services/user_service.dart';

class SplashScreenController extends GetxController {
  UserService _service = Get.put(UserService(), permanent: true);
  Authentication _authentication = Get.put(Authentication(), permanent: true);

  var loadingText = "Yükleniyor...".obs;

  Future<void> navigate() async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      // ToDo check is there a "current user"
      if (_authentication.err.value) {
        // ToDo make the app offline
        loadingText.value = "Bir hata olustu\nDaha sonra tekrar deneyin.";
      } else {
        Get.offAllNamed("/home");
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    navigate();
  }
}
