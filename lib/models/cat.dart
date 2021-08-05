import 'package:pet_care/models/activity_scheduler.dart';
import 'package:pet_care/models/pet.dart';

class Cat extends Pet {
  Cat(
      {String? id,
      required String name,
      required ActivityScheduler feedingActivity,
      String? breed,
      DateTime? birthdayDate,
      ActivityScheduler? fillWaterActivity})
      : super(
            id: id,
            name: name,
            feedingActivity: feedingActivity,
            birthdayDate: birthdayDate,
            fillWaterActivity: fillWaterActivity,
            species: "Cat",
            breed: breed);
}
