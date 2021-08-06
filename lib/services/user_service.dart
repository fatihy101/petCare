import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pet_care/models/pet_owner.dart';
import 'package:pet_care/services/fire_store_service.dart';

class UserService extends GetxController {
  static final userInfoCollection = "usersInformation";
  Rx<PetOwner?> petOwner = null.obs;

  Future setUser(User user) async {
    var userInformation =
        await FireStoreServices.getByDocID(userInfoCollection, user.uid);
    if (userInformation != null) {
      petOwner = PetOwner(
              uid: user.uid,
              displayName: userInformation["nameSurname"],
              email: userInformation["email"],
              petIDs: userInformation["petIDs"] == null
                  ? null
                  : List.from(userInformation["petIDs"]),
              photoURL: user.photoURL ?? null,
              avatarName: userInformation["avatar"] ?? null)
          .obs;
    } else {
      log("User information is null", name: "setUser error");
    }
  }

  Future saveGUserInformation(User user) async {
    final doc =
        FirebaseFirestore.instance.collection(userInfoCollection).doc(user.uid);
    final snapShot = await doc.get();

    if (!snapShot.exists) {
      doc.set({"email": user.email, "nameSurname": user.displayName});
    }
  }

  saveToStoreUser(String email, nameSurname, avatarName, uid) {
    FireStoreServices.saveToStore(userInfoCollection, docID: uid, data: {
      "nameSurname": nameSurname,
      "email": email,
      "avatar": avatarName
    }, thenCallback: (value) {
      log("User added", name: "UserService Success");
      petOwner.value = PetOwner(
          uid: uid,
          displayName: nameSurname,
          email: email,
          avatarName: avatarName);
    }, errorCallback: (error) {
      log(error.toString(), name: "UserService error");
    });
  }
}
