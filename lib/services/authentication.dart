import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_care/services/user_service.dart';
import 'package:pet_care/widgets/custom_snackbar.dart';

class Authentication extends GetxController {
  var _isInitialized = false.obs;
  var err = false.obs;
  var isUserSignedIn = false.obs;
  FirebaseApp? _firebaseApp;
  FirebaseAuth? _auth;
  UserService _userService = Get.find();

  @override
  void onInit() async {
    super.onInit();
    await initFirebase();
    if (_isInitialized.value && _auth == null) _auth = FirebaseAuth.instance;
    await setUserToService();
  }
  Future setUserToService() async {
    if (_firebaseApp == null) _firebaseApp = await Firebase.initializeApp();
    if (currentUser != null && _userService.petOwner.value == null) {
      await _userService.setUser(currentUser!);
      isUserSignedIn.value = true;
    }
  }


  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      isUserSignedIn.value = false;
      _userService.petOwner = null.obs;
    } catch (e) {
      log(e.toString());
      CustomSnackBar.getSnackBar("Hata", "Beklenmeyen bir hata oluştu!");
    }
  }

  login(String email, password) async {
    try {
      User? user = (await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)).user;
      isUserSignedIn.value = true;
      await _userService.setUser(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessengerState().showSnackBar(
            CustomSnackBar(text: "Bu e-postaya ait kullanıcı bulunamadı.")
                as SnackBar);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessengerState().showSnackBar(
            CustomSnackBar(text: "Yanlış parola girdiniz.") as SnackBar);
      }
    }
  }

  static bool isEmailValid(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  Future<void> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        User? user = (await auth.signInWithCredential(credential)).user;
        if (user != null) {
          isUserSignedIn.value = true;
          _userService.saveGUserInformation(user);
          _userService.setUser(user);
        } else {
          throw Exception("User is null. Something went wrong on getting user information. Stack trace: Google sign in");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          log("account-exists-with-different-credential",
              name: "Error on Google Sign in");
        } else if (e.code == 'invalid-credential') {
          CustomSnackBar.getSnackBar("E-posta veya parolanız yanlış", "");
          log("invalid-credential", name: "Error on Google Sign in");
        }
      } catch (e) {
        CustomSnackBar.getSnackBar("Hata", "Beklenmeyen bir hata oluştu");
        log(e.toString(), name: "Error on Google Sign in");
      }
    } else { // FixMe
      _userService.setUser(googleSignInAccount as User);
    }
  }

  Future<User?> signUpEmailPass(String email, password) async {
    _initAuthIfNotExist();
    try {
      if (_firebaseApp == null) _firebaseApp = await Firebase.initializeApp();
      UserCredential credentials = await _auth!
          .createUserWithEmailAndPassword(email: email, password: password);
      isUserSignedIn.value = true;
      return credentials.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        CustomSnackBar.getSnackBar("Girdiğiniz parola güvenli değil.",
            "Öneri: Büyük ve küçük harfler ve rakamları aynı anda kullanabilirsiniz.");
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        CustomSnackBar.getSnackBar(
            "Hata", "Girdiğiniz e-postayla hesabınız bulunuyor");
      }
    } catch (e) {
      CustomSnackBar.getSnackBar("Hata", "Beklenmeyen bir hata oluştu!");
      log(e.toString(), name: "Error on signUp");
    }
    return null;
  }

  _initAuthIfNotExist() {
    try {
      if (_auth == null) {
        _auth = FirebaseAuth.instance;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> initFirebase() async {
    if (!_isInitialized.value) {
      try {
        if (_firebaseApp == null) _firebaseApp = await Firebase.initializeApp();
        log("Firebase initialized.", name: "Firebase Info");
        _isInitialized.value = true;
        err.value = false;
      } catch (e) {
        log(e.toString(), name: "initFirebase Error");
      }
      update();
      return _isInitialized.value;
    } else
      return true;
  }
}
