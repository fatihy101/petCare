import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/extensions/conversions.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class ExpandableTimeSelector extends StatelessWidget {
  final RxList<TimeOfDay> selectedTimes;
  final String title;
  final String listTitle;
  final Color color;

  const ExpandableTimeSelector(
      {Key? key,
      required this.selectedTimes,
      required this.title,
      required this.color, required this.listTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30)),
        child: ExpandableNotifier(
          child: Expandable(
            collapsed: ExpandableButton(
                child: Text(
              title,
              style: Get.textTheme.bodyText2,
            )),
            expanded: Obx(
              () => Column(
                children: [
                  for (var i = 0; i < selectedTimes.length + 1; i++)
                    getHourRow(context, i),
                  ExpandableButton(
                    child: Column(
                      children: [
                        Icon(CupertinoIcons.chevron_up, color: Colors.white),
                        Text(
                          "Küçült",
                          style: Get.textTheme.bodyText2,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getHourRow(BuildContext context, int index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "${index + 1}.$listTitle",
              style: Get.textTheme.bodyText2,
            ),
          ),
          selectedTimes.length >= index + 1
              ? Text("${selectedTimes[index].formattedString}")
              : IconButton(
                  onPressed: () {
                    Navigator.push(context, timePicker(index));
                  },
                  icon: Icon(Icons.add_circle, color: Colors.white),
                ),
          SizedBox(
            width: 50,
          )
        ],
      );

  PageRouteBuilder timePicker(int index) => showPicker(
    borderRadius: 30,
    elevation: 20,
    is24HrFormat: true,
    accentColor: Get.theme.primaryColor,
    hourLabel: "Saat",
    minuteLabel: "Dakika",
    okText: "TAMAM",
    cancelText: "İPTAL",
    iosStylePicker: true,
    value: selectedTimes.asMap().containsKey(index)
        ? selectedTimes[index]
        : TimeOfDay(hour: 8, minute: 30),
    okCancelStyle: TextStyle(
        color: Get.theme.primaryColor, fontWeight: FontWeight.bold),
    onChange: (newTime) {
      if (selectedTimes.isEmpty ||
          !selectedTimes.asMap().containsKey(index)) {
        selectedTimes.add(newTime);
      } else
        selectedTimes[index] = newTime;
    },
  );
}
