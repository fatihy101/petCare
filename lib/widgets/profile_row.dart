import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileRow extends StatelessWidget {
  final String headline;
  final String text;
  final bool flexIt;

  const ProfileRow(
      {Key? key,
      required this.headline,
      required this.text,
      this.flexIt = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: flexIt ? 1 : 0,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      headline,
                      style: Get.textTheme.bodyText2!.copyWith(
                          fontSize: 18,
                          color: Get.theme.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: Get.textTheme.bodyText2!
                          .copyWith(fontSize: 18, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
            ),
          ],
        ),
      );
}
