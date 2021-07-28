import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPetController extends GetxController {
  var selections = [true, false, false].obs;
  TextEditingController nameText = TextEditingController();
  RxList<TimeOfDay> feedingTimes = List<TimeOfDay>.empty(growable: true).obs;
  RxList<TimeOfDay> waterTimes = List<TimeOfDay>.empty(growable: true).obs;
  RxList<TimeOfDay> walkingTimes = List<TimeOfDay>.empty(growable: true).obs;
  RxBool isTimeSelected = false.obs;


  resetSelections() => selections.setAll(0, [false, false, false]);
}
