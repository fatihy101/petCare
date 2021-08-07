import 'package:flutter/material.dart';

extension conversions on TimeOfDay {
  int toMinute() => this.minute + this.hour * 60;

  DateTime toDateTime() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, this.hour, this.minute);
  }

  String get formattedString => "${this.hour}:${this.minute}";
}

extension mapConversion on List<TimeOfDay> {
  List<Map<String, int>> toMap() {
    List<Map<String, int>> returnList = [];
    this.forEach((element) => returnList
        .add(<String, int>{"hour": element.hour, "minute": element.minute}));
    return returnList;
  }
}

String getMonthName(int month) {
  List<String> months = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];
  return months[month - 1];
}

extension dateTimeStringFormat on DateTime {
  withoutHourString() => "${this.day}/${this.month}/${this.year}";

  withDayAndHour() =>
      "${this.day} ${getMonthName(this.month)} ${this.hour}:${this.minute}";
}
