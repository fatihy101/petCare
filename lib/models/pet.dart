import 'activity_scheduler.dart';

class Pet {
  final String name;
  DateTime? birthdayDate;
  ActivityScheduler? fillWaterActivity;
  ActivityScheduler feedingActivity;
  String? species;

  Pet(
      {required this.name,
      this.fillWaterActivity,
      required this.feedingActivity,
      this.birthdayDate,
      this.species});

  Map<String, dynamic> toJsonMap() => <String, dynamic>{
        "name": name,
        "feedingActivity": feedingActivity.toJsonMap(),
        "birthdayDate": birthdayDate == null ? null : birthdayDate!.toUtc(),
        "fillWaterActivity":
            fillWaterActivity == null ? null : fillWaterActivity!.toJsonMap(),
        "species": species ?? null,
      };
}
