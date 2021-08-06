import 'package:cloud_firestore/cloud_firestore.dart';

import 'activity_scheduler.dart';
import 'bird.dart';
import 'cat.dart';
import 'dog.dart';

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

  Pet.fromJson(Map<String, dynamic> data)
      : id = data["id"],
        name = data["name"],
        feedingActivity = ActivityScheduler.fromJson(data, "feedingActivity"),
        breed = data["breed"] ?? null,
        birthdayDate = data["birthdayDate"] ?? null,
        fillWaterActivity = data["fillWaterActivity"] == null
            ? null
            : ActivityScheduler.fromJson(data, "fillWaterActivity");

  static Pet createPetFromJson(Map<String, dynamic> data) {
    switch (data["species"]) {
      case "Dog":
        return Dog(
            id: data["id"],
            name: data["name"],
            feedingActivity:
                ActivityScheduler.fromJson(data, "feedingActivity"),
            breed: data["breed"] ?? null,
            birthdayDate: data["birthdayDate"] == null
                ? null
                : (data["birthdayDate"] as Timestamp).toDate(),
            fillWaterActivity: data["fillWaterActivity"] == null
                ? null
                : ActivityScheduler.fromJson(data, "fillWaterActivity"),
            walkingActivity: data["walkingActivity"] == null
                ? null
                : ActivityScheduler.fromJson(data, "walkingActivity"));
      case "Cat":
        return Cat(
            id: data["id"],
            name: data["name"],
            feedingActivity:
                ActivityScheduler.fromJson(data, "feedingActivity"),
            breed: data["breed"] ?? null,
            birthdayDate: data["birthdayDate"] ?? null,
            fillWaterActivity: data["fillWaterActivity"] == null
                ? null
                : ActivityScheduler.fromJson(data, "fillWaterActivity"));
      case "Bird":
        return Bird(
            id: data["id"],
            name: data["name"],
            feedingActivity:
                ActivityScheduler.fromJson(data, "feedingActivity"),
            breed: data["breed"] ?? null,
            birthdayDate: data["birthdayDate"] ?? null,
            fillWaterActivity: data["fillWaterActivity"] == null
                ? null
                : ActivityScheduler.fromJson(data, "fillWaterActivity"));
      default:
        return Pet(
            id: data["id"],
            name: data["name"],
            feedingActivity:
                ActivityScheduler.fromJson(data, "feedingActivity"),
            breed: data["breed"] ?? null,
            species: data["species"],
            birthdayDate: data["birthdayDate"] ?? null,
            fillWaterActivity: data["fillWaterActivity"] == null
                ? null
                : ActivityScheduler.fromJson(data, "fillWaterActivity"));
    }
  }
}
