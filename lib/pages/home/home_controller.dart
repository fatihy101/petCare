import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/models/bird.dart';
import 'package:pet_care/models/cat.dart';
import 'package:pet_care/models/dog.dart';
import 'package:pet_care/models/pet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/services/pet_service.dart';
import 'package:pet_care/services/user_service.dart';
import 'dart:developer';

class HomeController extends GetxController {
  RxList<Tab> tabs = List<Tab>.empty(growable: true).obs;
  RxList<Widget> tabViews = List<Widget>.empty(growable: true).obs;
  PetService _petService = Get.find();
  UserService _userService = Get.find();

  Tab createTab(String petName, Pet pet) => Tab(
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: FaIcon(
                getIcon(pet),
                color: Get.theme.backgroundColor),
          ),
          Text(
            petName,
            style: GoogleFonts.courgette(
                color: Get.theme.backgroundColor,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
        ]),
  );

  IconData getIcon(Pet pet) {
    if (pet is Dog) return FontAwesomeIcons.dog;
    else if (pet is Cat) return FontAwesomeIcons.cat;
    else if (pet is Bird) return FontAwesomeIcons.dove;
    else return FontAwesomeIcons.paw;
  }

  bool isTabView() {
    if (tabs.length > 1 || tabViews.length > 1) {
      return true;
    } else {
      return false;
    }
  }

@override
  void onInit() {
    super.onInit();
    if(_userService.petOwner.value != null) {
      _petService.petIDs = _userService.petOwner.value?.petIDs ?? [];
      _petService.getPetsByID();
    }
  }


}
