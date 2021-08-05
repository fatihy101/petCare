import 'package:pet_care/models/pet.dart';

import 'activity_scheduler.dart';

class Bird extends Pet {
  Bird(
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
            species: "Bird",
            breed: breed);
}
