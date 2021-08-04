import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/services/authentication.dart';
import 'package:pet_care/widgets/profile_row.dart';
import 'package:pet_care/widgets/widgets.dart';

class UserProfileView extends StatelessWidget {
  final Authentication _authentication = Get.find();

  @override
  Widget build(BuildContext context) => SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                _authentication.userService.photoURL.value != ""
                    ? NetworkImage(
                    _authentication.userService.photoURL.value)
                    : AssetImage(_authentication.userService.avatarName.value) as ImageProvider,
              ),
              Visibility(
                  child: ProfileRow(
                      headline: "Ad Soyad",
                      text: _authentication.userService.displayName.value)),
              ProfileRow(
                  headline: "Email", text: _authentication.userService.email.value),
              SizedBox(height: 10),
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
        ),
      ));
}
