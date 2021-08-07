import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/models/activity_scheduler.dart';
import 'package:pet_care/models/dog.dart';
import 'package:pet_care/models/pet.dart';
import 'package:pet_care/widgets/profile_row.dart';
import 'package:pet_care/extensions/conversions.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PetInformationView extends StatefulWidget {
  final Pet pet;

  const PetInformationView({Key? key, required this.pet}) : super(key: key);

  @override
  _PetInformationViewState createState() => _PetInformationViewState();
}

class _PetInformationViewState extends State<PetInformationView> {
  late Pet pet;

  @override
  void initState() {
    super.initState();
    pet = widget.pet;
  }

  Widget activityView(ActivityScheduler activity, String text, Color color) =>
      InkWell(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Önceki: ",
                        style: Get.textTheme.bodyText2!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        activity.previousTime!.withDayAndHour(),
                        style: Get.textTheme.bodyText2!
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Sonraki: ",
                        style: Get.textTheme.bodyText2!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        activity.nextTime!.withDayAndHour(),
                        style: Get.textTheme.bodyText2!
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 12.0,
                animation: true,
                backgroundColor: Colors.grey.shade200,
                percent: activity.remainingActivityPoints <= 0
                    ? 0
                    : activity.remainingActivityPoints,
                center: Text(
                  "${activity.remainingActivityPoints.toStringAsFixed(2)}%",
                  style: Get.textTheme.bodyText2!.copyWith(color: Colors.black),
                ),
                footer: Text(
                  text,
                  style: Get.textTheme.bodyText2!.copyWith(color: Colors.black),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Get.theme.primaryColor,
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ProfileRow(headline: "ADI", text: pet.name, flexIt: false),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileRow(headline: "TÜRÜ", text: pet.breed!, flexIt: false),
                Visibility(
                  visible: pet.birthdayDate != null,
                  child: ProfileRow(
                      headline: "DOĞUM TARİHİ",
                      text: pet.birthdayDate!.withoutHourString(),
                      flexIt: false),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24.0),
                child: activityView(
                    pet.feedingActivity, "Açlık", Colors.orange.shade300)),
            Visibility(
              visible: pet.fillWaterActivity != null,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24.0),
                  child: activityView(
                      pet.fillWaterActivity!, "Su", Get.theme.accentColor)),
            ),
            if (pet is Dog)
              Visibility(
                visible: (pet as Dog).walkingActivity != null,
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 24.0),
                    child: activityView((pet as Dog).walkingActivity!,
                        "Yürüyüş", Colors.orange.shade300)),
              )
          ],
        )),
      ),
    );
  }
}
