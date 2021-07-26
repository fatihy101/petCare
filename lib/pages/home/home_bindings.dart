import 'package:get/get.dart';
import 'package:pet_care/pages/home/home_controller.dart';
import 'package:pet_care/pages/login/login_controller.dart';

class HomeBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
  }

}