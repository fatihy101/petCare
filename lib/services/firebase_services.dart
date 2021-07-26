import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class FirebaseServices extends GetxController {
  var _isInitialized = false.obs;
  var err = false.obs;
  FirebaseAuth? _auth;

  @override
  void onInit() async {
    super.onInit();
    await initFirebase();
    if (_isInitialized.value && _auth == null) _auth = FirebaseAuth.instance;
  }

  FirebaseAuth get getAuth {
    if (_auth != null) {
      return _auth!;
    } else {
      _auth = FirebaseAuth.instance;
      return _auth!;
    }
  }

  Future<UserCredential?> signUpEmailPass(String email, password) async {
    _initAuthIfNotExist();
    try {
      UserCredential credential = await _auth!
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      log(e.toString(), name: "Error on signUp");
      return null;
    }
  }

  _initAuthIfNotExist() {
    if (_auth == null) {
      _auth = FirebaseAuth.instance;
    }
  }

  Future<bool> initFirebase() async {
    if (!_isInitialized.value) {
      try {
        await Firebase.initializeApp();
        log("Firebase initialized.",name: "Firebase Info");
        _isInitialized.value = true;
        err.value = false;
      } catch (e) {
        log(e.toString(), name: "initFirebase Error");
        err.value = true;
        _isInitialized.value = false;
      }
      update();
      return _isInitialized.value;
    } else
      return true;
  }
}
