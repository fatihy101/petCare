
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_care/models/pet.dart';
import 'package:pet_care/services/fire_store_service.dart';
import 'package:pet_care/services/user_service.dart';
import 'package:pet_care/widgets/custom_snackbar.dart';

class PetService extends GetxController {
  static const petCollectionName = "petsInformation";
  RxList<Pet> pets = List<Pet>.empty(growable: true).obs;
  List<String> petIDs = [];

  Future getPetsByID() async {
    if(petIDs.isNotEmpty) {
      // Get pets by documentID.
      log(petIDs.toString(),name: "pet ids");
      // Create pet objects.

      // Add to list.
    }
  }

  Future addPet(Map<String, dynamic> petData, String uid) async {
    var docRef =
        await FireStoreServices.saveToStore(petCollectionName, data: petData);
    if (docRef == null) {
      CustomSnackBar.getSnackBar(
          "Evcil hayvanı eklerken hata oluştu", "Daha sonra tekrar deneyiniz.");
    } else if (docRef is DocumentReference) {
      List<String> newIds = [];
      if (pets.isNotEmpty) newIds = pets.map((e) => e.id!).toList();
      newIds.add(docRef.id);
      var success = await FireStoreServices.updateByDocID(
          collectionName: UserService.userInfoCollection,
          docID: uid,
          data: {"petIDs": newIds});
      Get.back();
      CustomSnackBar.getSnackBar(
          "Başarılı!", "Evcil hayvanınız eklendi");
      if(!success) {
        CustomSnackBar.getSnackBar(
            "Evcil hayvanı eklerken hata oluştu", "Daha sonra tekrar deneyiniz.");
      }
    }
  }
}
