import 'package:flutter/material.dart';
import 'package:pet_care/extensions/index.dart';

class Pet {
  final String name;
  List<TimeOfDay>? fillWaterTimes;
  List<TimeOfDay> feedingTimes;
  DateTime? previousFeedingTime;
  DateTime? nextFeedingTime;
  TimeOfDay? previousWaterTime;
  TimeOfDay? nextWaterTime;

  Pet({required this.name, this.fillWaterTimes, required this.feedingTimes}) {
    initPreviousAndNext();
  }

  initPreviousAndNext() {
    Duration oneDay = Duration(days: 1);
    var now = TimeOfDay.now();
    if (feedingTimes.length > 1) {
      feedingTimes.forEach((element) {
        if (element.toMinute() > now.toMinute())
          nextFeedingTime = element.toDateTime();
        else
          previousFeedingTime = element.toDateTime();
      });
      if (nextFeedingTime == null) {
        // It's end of the day. So first feeding hour must be the next feeding hour.
        nextFeedingTime = feedingTimes.earliestHour.toDateTime().add(oneDay);
      } else if (previousFeedingTime == null) {
        // It's the beginning of the day. Last feeding hour of yesterday must be the previous feeding hour.
        previousFeedingTime =
            feedingTimes.latestHour.toDateTime().subtract(oneDay);
      }
    } else if (feedingTimes.length == 1) {
      if (now.hour > feedingTimes.first.hour) {
        previousFeedingTime = feedingTimes.first.toDateTime();
        nextFeedingTime = feedingTimes.first.toDateTime().add(oneDay);
      } else {
        previousFeedingTime = feedingTimes.first.toDateTime().subtract(oneDay);
        nextFeedingTime = feedingTimes.first.toDateTime();
      }
    }
  }

  double get remainingHungerPoints {
    var now = DateTime.now();

    int diffNextPrev =
        nextFeedingTime!.difference(previousFeedingTime!).inMinutes;
    double decreasingPointByMinute = 100 / diffNextPrev;
    int passingMinute = (now.difference(previousFeedingTime!).inMinutes).abs();
    return 100 - passingMinute * decreasingPointByMinute;
  }
}
