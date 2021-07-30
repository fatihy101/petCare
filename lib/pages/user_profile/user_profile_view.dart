import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/services/authentication.dart';
import 'package:pet_care/widgets/widgets.dart';

class UserProfileView extends StatelessWidget {
  final Authentication _authentication = Get.find();

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            BlockIconButton(
                onPressed: () {
                  _authentication.signOut();
                  Get.back();
                },
                color: Get.theme.primaryColor,
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                text: "Çıkış Yap"),
          ],
        ),
      ));
}
