import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var pets = [].obs;
  RxList<Tab> tabs = List<Tab>.empty(growable: true).obs;
  RxList<Widget> tabViews = List<Widget>.empty(growable: true).obs;

  bool isTabView() {
    if (tabs.length > 1 || tabViews.length > 1) {
      return true;
    } else {
      return false;
    }
  }



}
