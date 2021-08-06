import 'package:pet_care/models/activity_scheduler.dart';
import 'package:pet_care/models/pet.dart';

class Dog extends Pet {
  String? id;
  final String name;
  String? breed;
  DateTime? birthdayDate;
  ActivityScheduler? fillWaterActivity;
  ActivityScheduler feedingActivity;
  ActivityScheduler? walkingActivity;

  Dog({this.id,
    required this.name,
    required this.feedingActivity,
    this.breed,
    this.birthdayDate,
    this.fillWaterActivity,
    this.walkingActivity})
      : super(
      id: id,
      name: name,
      feedingActivity: feedingActivity,
      birthdayDate: birthdayDate,
      fillWaterActivity: fillWaterActivity,
      species: "Dog",
      breed: breed);

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
