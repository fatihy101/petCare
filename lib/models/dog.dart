import 'package:flutter/material.dart';
import 'package:pet_care/models/pet.dart';

class Dog extends Pet {
  final String name;
  final List<TimeOfDay> feedingTimes;

  Dog(this.name, this.feedingTimes)
      : super(name: name, feedingTimes: feedingTimes);

}
