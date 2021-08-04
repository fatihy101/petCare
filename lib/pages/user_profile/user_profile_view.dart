import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/services/authentication.dart';
import 'package:pet_care/services/user_service.dart';
import 'package:pet_care/widgets/profile_row.dart';
import 'package:pet_care/widgets/widgets.dart';

class UserProfileView extends StatelessWidget {
  final Authentication _authentication = Get.find();
  final UserService _userService = Get.find();

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
                backgroundImage: _userService.petOwner.value!.photoURL != null
                    ? NetworkImage(_userService.petOwner.value!.photoURL!)
                    : AssetImage(_userService.petOwner.value!.avatarName!)
                        as ImageProvider,
              ),
              Visibility(
                  child: ProfileRow(
                      headline: "Ad Soyad",
                      text: _userService.petOwner.value!.displayName)),
              ProfileRow(
                  headline: "Email", text: _userService.petOwner.value!.email),
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
