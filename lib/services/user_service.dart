import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static Future saveUserInformation(String email, nameSurname) async {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("usersInformation");
    await users
        .add({"nameSurname": nameSurname, "email": email})
        .then((value) => log("User added", name:"UserService Success"))
        .catchError((error) {
          log(error.toString(), name: "UserService error");
        });
  }
}
