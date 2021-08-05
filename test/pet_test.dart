import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_care/models/activity_scheduler.dart';
import 'package:pet_care/models/dog.dart';
import 'package:pet_care/models/pet.dart';

main() {
  group("hunger points", () {
    Exception valueErr = Exception("Invalidv alue");
    String desc1 = "Remaining hunger points for two values";
    String desc2 = "For one values";
    String desc3 = "for multiple";

    testBody(List<TimeOfDay> feedingTimes, String description) {
      Pet pet = Pet(
          name: "Guinea Pig",
          feedingActivity: ActivityScheduler(scheduledTimes: feedingTimes));
      var remainingPoints = pet.feedingActivity.remainingActivityPoints;
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

  group("Initialize and convert to json", () {
    List<TimeOfDay> feedingTimes = [
      TimeOfDay(hour: 11, minute: 0),
      TimeOfDay(hour: 9, minute: 30)
    ];

    List<TimeOfDay> fillWaterTimes = [
      TimeOfDay(hour: 15, minute: 20),
      TimeOfDay(hour: 10, minute: 40)
    ];
    test("pet initialization", () {
      Pet pet = Pet(
          name: "Test pet",
          feedingActivity: ActivityScheduler(scheduledTimes: feedingTimes),
          fillWaterActivity: ActivityScheduler(scheduledTimes: fillWaterTimes));
      print("Pet json: " + pet.toJsonMap().toString());
    });

    test("Dog initialization", () {
      Dog dog = Dog(
        name: "Test dog",
        feedingActivity: ActivityScheduler(scheduledTimes: feedingTimes),
        walkingActivity: ActivityScheduler(scheduledTimes: fillWaterTimes),
        fillWaterActivity: ActivityScheduler(scheduledTimes: feedingTimes),
      );
      print("Dog json: " + dog.toJsonMap().toString());
    });
  });

  test("List<Pet> to list of String for ids", () {
    List<TimeOfDay> feedingTimes = [
      TimeOfDay(hour: 11, minute: 0),
      TimeOfDay(hour: 9, minute: 30)
    ];
    List<Pet> pets = List.empty(growable: true);
    pets.add(Pet(
        id: "1a",
        name: "Test",
        feedingActivity: ActivityScheduler(scheduledTimes: feedingTimes)));
    pets.add(Pet(
        id: "3b",
        name: "Test 2",
        feedingActivity: ActivityScheduler(scheduledTimes: feedingTimes)));

    List<String> ids = pets.map((e) => e.id!).toList();
    print(ids.toString());
    expect(ids, ["1a", "3b"]);
  });
}
