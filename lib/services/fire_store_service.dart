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

  static Future saveToStore(
      String collectionName,
      {required Map<String, dynamic> data,
      required String docID,
      required Function(void) thenCallback,
      required Function(dynamic) errorCallback}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection(collectionName);
/*   */
    await users.doc(docID).set(data).then(thenCallback).catchError(errorCallback);
  }
}
