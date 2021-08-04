import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pet_care/services/fire_store_service.dart';

class UserService extends GetxController {
  RxString displayName = "".obs;
  RxString photoURL = "".obs;
  RxString avatarName = "".obs;
  RxString email = "".obs;
  RxString uid = "".obs;
  var petIds = [].obs;
  final userInfoCollection = "usersInformation";

  setUser(User user) async {
    uid.value = user.uid;
    var userInformation =
        await FireStoreServices.getByDocID(userInfoCollection, uid.value);
    if(userInformation != null) {
      petIds.value = userInformation["petIds"] ?? [];
      displayName.value = userInformation["nameSurname"];
      email.value = userInformation["email"];

      if (user.photoURL == null) {
        avatarName.value = userInformation["avatar"];
      } else {
        photoURL.value = user.photoURL!;
      }
    } else {

    }
  }

  resetUserValues() {
    displayName = "".obs;
    photoURL = "".obs;
    email = "".obs;
    uid = "".obs;
    avatarName = "".obs;
    petIds = [].obs;
  }

  Future saveGUserInformation(User user) async {
    final doc =
        FirebaseFirestore.instance.collection(userInfoCollection).doc(user.uid);
    final snapShot = await doc.get();

    if (!snapShot.exists) {
      doc.set({"email": user.email, "nameSurname": user.displayName});
    }
  }

  Future saveUserInformation(String email, nameSurname, avatarName, uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection(userInfoCollection);

    await users.doc(uid).set({
      "nameSurname": nameSurname,
      "email": email,
      "avatar": avatarName
    }).then((value) {
      log("User added", name: "UserService Success");
      displayName.value = nameSurname;
      this.email.value = email;
      this.avatarName.value = avatarName;
      this.uid = uid;
    }).catchError((error) {
      log(error.toString(), name: "UserService error");
    });
  }
}
