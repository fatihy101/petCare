import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar extends StatelessWidget {
  final String text;

  const CustomSnackBar({Key? key, required this.text}) : super(key: key);

  static getSnackBar(String title, message) =>
      Get.snackbar(
        title,
        message,
        duration: Duration(seconds: 2),
        backgroundColor: Get.theme.cardColor,
        colorText: Get.theme.primaryColor,
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        overlayBlur: 3,
      );

  @override
  Widget build(BuildContext context) {
    return SnackBar(content: Text(
      text, style: Get.textTheme.bodyText2!.copyWith(color: Colors.white)),
        shape: StadiumBorder(),
        backgroundColor: Get.theme.primaryColor);
  }
}