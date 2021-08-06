import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/extensions/index.dart';

class ActivityScheduler {
  List<TimeOfDay> scheduledTimes;
  DateTime? previousTime;
  DateTime? nextTime;

  ActivityScheduler({required this.scheduledTimes}) {
    initPreviousAndNext();
  }

  Map<String, dynamic> toJsonMap() => <String, dynamic>{
        "scheduledTimes": scheduledTimes.toMap(),
        "previousTime": previousTime == null ? null : previousTime!.toLocal(),
        "nextTime": nextTime == null ? null : nextTime!.toLocal()
      };

  ActivityScheduler.fromJson(Map<String, dynamic> json, String activityName)
      : nextTime = (json[activityName]["nextTime"] as Timestamp).toDate(),
        previousTime = (json[activityName]["previousTime"] as Timestamp).toDate(),
        scheduledTimes = listMapToTimeOfDay(json[activityName]["scheduledTimes"] as List<dynamic>);

  static List<TimeOfDay> listMapToTimeOfDay(List<dynamic> mapList) {
    List<TimeOfDay> returnList = [];
    mapList.forEach((element) => returnList.add(TimeOfDay(
        hour: element["hour"] as int, minute: element["minute"] as int)));
    return returnList;
  }

  double get remainingActivityPoints {
    var now = DateTime.now();
    int diffNextPrev = nextTime!.difference(previousTime!).inMinutes;
    double decreasingPointByMinute = 100 / diffNextPrev;
    int passingMinute = (now.difference(previousTime!).inMinutes).abs();
    return 100 - passingMinute * decreasingPointByMinute;
  }

  initPreviousAndNext() {
    Duration oneDay = Duration(days: 1);
    var now = TimeOfDay.now();
    if (scheduledTimes.length > 1) {
      scheduledTimes.forEach((element) {
        if (element.toMinute() > now.toMinute()) {
          if (nextTime == null ||
              nextTime!.compareTo(element.toDateTime()) > 0) {
            nextTime = element.toDateTime();
          }
        } else {
          if (previousTime == null ||
              previousTime!.compareTo(element.toDateTime()) < 0) {
            previousTime = element.toDateTime();
          }
        }
      });
      if (nextTime == null) {
        // It's end of the day. So first hour of activity must be the next hour of activity.
        nextTime = scheduledTimes.earliestHour.toDateTime().add(oneDay);
      } else if (previousTime == null) {
        // It's the beginning of the day. Yesterday's last hour of activity must be the previous hour of activity .
        previousTime = scheduledTimes.latestHour.toDateTime().subtract(oneDay);
      }
    } else if (scheduledTimes.length == 1) {
      if (now.hour > scheduledTimes.first.hour) {
        previousTime = scheduledTimes.first.toDateTime();
        nextTime = scheduledTimes.first.toDateTime().add(oneDay);
      } else {
        previousTime = scheduledTimes.first.toDateTime().subtract(oneDay);
        nextTime = scheduledTimes.first.toDateTime();
      }
    }
  }
}
