import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pet_care/services/authentication.dart';

void main() {
  test("Testing firebase and auth services", () async {
    Authentication services = Get.put(Authentication());
    await services.signUpEmailPass("test@test.com", "aaa123123");

    if(!services.isUserSignedIn.value) {
      throw Exception("Credentials is null");
    }

    // expect(cred!.user!.email, "test@test.com");
  });


}