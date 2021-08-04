import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/models/dog.dart';
import 'package:pet_care/models/pet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeController extends GetxController {
  var pets = [].obs;
  RxList<Tab> tabs = List<Tab>.empty(growable: true).obs;
  RxList<Widget> tabViews = List<Widget>.empty(growable: true).obs;

  Tab createTab(String petName, Pet pet) => Tab(
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: FaIcon(
                pet is Dog ? FontAwesomeIcons.dog : FontAwesomeIcons.cat,
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

  bool isTabView() {
    if (tabs.length > 1 || tabViews.length > 1) {
      return true;
    } else {
      return false;
    }
  }



}
