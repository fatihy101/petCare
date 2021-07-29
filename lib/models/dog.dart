import 'package:pet_care/models/activity_scheduler.dart';
import 'package:pet_care/models/pet.dart';

class Dog extends Pet {
  final String name;
  DateTime? birthdayDate;
  ActivityScheduler? fillWaterActivity;
  ActivityScheduler feedingActivity;
  ActivityScheduler? walkingActivity;

  Dog(
      {required this.name,
      required this.feedingActivity,
      this.birthdayDate,
      this.fillWaterActivity,
      this.walkingActivity})
      : super(
            name: name,
            feedingActivity: feedingActivity,
            birthdayDate: birthdayDate,
            fillWaterActivity: fillWaterActivity,
            species: "Dog");

  @override
  Map<String, dynamic> toJsonMap() {
    Map<String, dynamic> inheritedMap = super.toJsonMap();
    inheritedMap.addAll(<String, dynamic>{
      "walkingActivity":
          walkingActivity == null ? null : walkingActivity!.toJsonMap(),
    });
    return inheritedMap;
  }
}
