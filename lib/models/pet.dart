import 'activity_scheduler.dart';

class Pet {
  String? id;
  final String name;
  DateTime? birthdayDate;
  String? breed;
  ActivityScheduler? fillWaterActivity;
  ActivityScheduler feedingActivity;
  String? species;

  Pet(
      {this.id,
      required this.name,
      this.fillWaterActivity,
      required this.feedingActivity,
      this.birthdayDate,
      this.species,
      this.breed});

  Map<String, dynamic> toJsonMap() => <String, dynamic>{
        "name": name,
        "feedingActivity": feedingActivity.toJsonMap(),
        "birthdayDate": birthdayDate == null ? null : birthdayDate!.toUtc(),
        "fillWaterActivity":
            fillWaterActivity == null ? null : fillWaterActivity!.toJsonMap(),
        "species": species ?? null,
        "breed": breed ?? null
      };
}
