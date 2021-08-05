import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  static Future<Map<String, dynamic>?> getByDocID(
      String collectionName, id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection(collectionName);

    DocumentSnapshot snapshot = (await collection.doc(id).get());
    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  static Future<bool> updateByDocID(
      {required String collectionName,
      required String docID,
      required Map<String, dynamic> data}) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionName);
    try {
      await collection.doc(docID).update(data);
      return true;
    } catch (e) {
      log(e.toString(), name: "updateByDocID error");
      return false;
    }
  }

  /// If you provide [docID], you must also provide [thenCallback] and [errorCallback]
  /// Otherwise it'll return `null`.
  static Future<dynamic> saveToStore(String collectionName,
      {required Map<String, dynamic> data,
      String? docID,
      Function(void)? thenCallback,
      Function(dynamic)? errorCallback}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection(collectionName);
    if (docID != null) {
      if (thenCallback != null && errorCallback != null) {
        return await users
            .doc(docID)
            .set(data)
            .then(thenCallback)
            .catchError(errorCallback);
      } else {
        log("You must provide thenCallback and errorCallback with docID",
            name: "saveToStore Error");
        return null;
      }
    } else {
      try {
        DocumentReference docRef = await users.add(data);
        return docRef;
      } catch (err) {
        log(err.toString(), name: "saveToStore Error");
        return null;
      }
    }
  }
}
