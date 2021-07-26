
import 'package:flutter/material.dart';

extension findValues on List<TimeOfDay> {
  TimeOfDay get earliestHour {
    TimeOfDay? earlyHour;
    this.forEach((element) {
      if (earlyHour == null) {
        earlyHour = element;
      } else if (element.hour < earlyHour!.hour) {
        earlyHour = element;
      }
    });
    return earlyHour!;
  }

  TimeOfDay get latestHour {
    TimeOfDay? lateHour;
    this.forEach((element) {
      if (lateHour == null) {
        lateHour = element;
      } else if (element.hour > lateHour!.hour) {
        lateHour = element;
      }
    });
    return lateHour!;
  }
}
