import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/services/firebase_services.dart';

class SplashScreenController extends GetxController {
  FirebaseServices services = Get.put(FirebaseServices(), permanent: true);
  var loadingText = "Yükleniyor...".obs;

  Future<void> navigate() async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      // ToDo check is there a "current user"
      if (services.err.value) {
        // ToDo make the app offline
        loadingText.value = "Bir hata olustu\nDaha sonra tekrar deneyin.";
        update();
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
