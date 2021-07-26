import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_care/models/pet.dart';

main() {
  group("hunger points", () {
    Exception valueErr = Exception("Invalid value");
    String desc1 = "Remaining hunger points for two values";
    String desc2 = "For one values";
    String desc3 = "for multiple";

    testBody(List<TimeOfDay> feedingTimes, String description) {
      Pet pet = Pet(name: "Guinea Pig", feedingTimes: feedingTimes);
      var remainingPoints = pet.remainingHungerPoints;
      print("$description, RHP: " + remainingPoints.toString());
      if (remainingPoints > 100 || remainingPoints < 0) throw valueErr;
    }

    test(desc1, () {
      List<TimeOfDay> feedingTimes = [
        TimeOfDay(hour: 11, minute: 0),
        TimeOfDay(hour: 9, minute: 30)
      ];
      testBody(feedingTimes, desc1);
    });

    test(desc2, () {
      List<TimeOfDay> feedingTimes = [TimeOfDay(hour: 20, minute: 30)];
      testBody(feedingTimes, desc2);
    });

    test(desc3, () {
      List<TimeOfDay> feedingTimes = [
        TimeOfDay(hour: 20, minute: 30),
        TimeOfDay(hour: 10, minute: 30),
        TimeOfDay(hour: 7, minute: 2)
      ];
      testBody(feedingTimes, desc3);
    });
  });
}
