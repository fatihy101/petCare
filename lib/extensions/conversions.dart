import 'package:flutter/material.dart';

extension conversions on TimeOfDay {
  int toMinute() => this.minute + this.hour * 60;

  DateTime toDateTime() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, this.hour, this.minute);
  }
}