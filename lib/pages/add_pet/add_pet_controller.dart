import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/models/activity_scheduler.dart';
import 'package:pet_care/models/bird.dart';
import 'package:pet_care/models/cat.dart';
import 'package:pet_care/models/dog.dart';
import 'package:pet_care/models/pet.dart';
import 'package:pet_care/services/authentication.dart';
import 'package:pet_care/services/pet_service.dart';
import 'package:pet_care/widgets/custom_snackbar.dart';

class AddPetController extends GetxController {
  RxList<bool> selections = [true, false, false].obs;
  TextEditingController nameText = TextEditingController();
  TextEditingController breedText = TextEditingController();
  RxList<TimeOfDay> feedingTimes = List<TimeOfDay>.empty(growable: true).obs;
  RxList<TimeOfDay> waterTimes = List<TimeOfDay>.empty(growable: true).obs;
  RxList<TimeOfDay> walkingTimes = List<TimeOfDay>.empty(growable: true).obs;
  RxBool isTimeSelected = false.obs;
  PetService _petService = Get.find();
  Authentication _authentication = Get.find();

  resetSelections() => selections.setAll(0, [false, false, false]);

  bool checkCommonFields() {
    if (feedingTimes.isNotEmpty &&
        waterTimes.isNotEmpty &&
        nameText.text != "" &&
        breedText.text != "")
      return true;
    else
      return false;
  }

  savePet(DateTime birthdayDate) async {
    Pet? newPet;

    if (selections[0]) {
      if (checkCommonFields() &&
          walkingTimes.isNotEmpty) {
        newPet = Dog(
          name: nameText.text,
          breed: breedText.text,
          birthdayDate: birthdayDate,
          feedingActivity: ActivityScheduler(scheduledTimes: feedingTimes),
          fillWaterActivity: ActivityScheduler(scheduledTimes: waterTimes),
          walkingActivity: ActivityScheduler(scheduledTimes: walkingTimes),
        );
      } else {
        CustomSnackBar.getSnackBar("Tüm alanları doldurmadınız!",
            "İstenilen tüm saatler için en az 1 saat dilimi eklediğinizden emin olun");
      }
    } else if (selections[1]) {
      if (checkCommonFields()) {
        newPet = Cat(
          name: nameText.text,
          breed: breedText.text,
          birthdayDate: birthdayDate,
          feedingActivity: ActivityScheduler(scheduledTimes: feedingTimes),
          fillWaterActivity: ActivityScheduler(scheduledTimes: waterTimes),
        );
      } else {
        CustomSnackBar.getSnackBar("Tüm alanları doldurmadınız!",
            "İstenilen tüm saatler için en az 1 saat dilimi eklediğinizden emin olun");
      }
    } else if (selections[2]) {
      if (checkCommonFields()) {
        newPet = Bird(
          name: nameText.text,
          breed: breedText.text,
          birthdayDate: birthdayDate,
          feedingActivity: ActivityScheduler(scheduledTimes: feedingTimes),
          fillWaterActivity: ActivityScheduler(scheduledTimes: waterTimes),
        );
      } else {
        CustomSnackBar.getSnackBar("Tüm alanları doldurmadınız!",
            "İstenilen tüm saatler için en az 1 saat dilimi eklediğinizden emin olun");
      }
    }
    // TODO check current user
    if (newPet != null)
      await _petService.addPet(
          newPet.toJsonMap(), _authentication.currentUser!.uid);
  }


}
