import 'package:get/get.dart';
import 'package:pet_care/services/authentication.dart';
import 'package:pet_care/services/pet_service.dart';
import 'package:pet_care/services/user_service.dart';

class SplashBindings extends Bindings{
  @override
  void dependencies() {
  Get.put(UserService(), permanent: true);
  Get.put(Authentication(), permanent: true);
  Get.put(PetService(), permanent: true);
  }

}