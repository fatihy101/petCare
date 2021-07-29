import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pet_care/pages/add_pet/add_pet_controller.dart';
import 'package:pet_care/pages/add_pet/expandable_time_selector.dart';

class AddPetView extends StatelessWidget {
  final AddPetController _controller = Get.put(AddPetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Evcil Hayvan Ekle",
              style: Get.theme.appBarTheme.titleTextStyle),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Tür",
                      style: Get.textTheme.bodyText2!
                          .copyWith(color: Get.theme.primaryColor),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                          () =>
                          ToggleButtons(
                              selectedColor: Get.theme.primaryColor,
                              color: Get.theme.primaryColor.withAlpha(190),
                              splashColor: Get.theme.backgroundColor,
                              fillColor: Get.theme.accentColor,
                              borderRadius: BorderRadius.circular(30),
                              constraints:
                              BoxConstraints(minWidth: 100, minHeight: 40),
                              selectedBorderColor: Get.theme.primaryColor,
                              children: [
                                FaIcon(FontAwesomeIcons.dog, size: 30),
                                FaIcon(FontAwesomeIcons.cat, size: 30),
                                FaIcon(FontAwesomeIcons.crow, size: 30),
                              ],
                              isSelected: _controller.selections,
                              onPressed: (index) {
                                if (!_controller.selections[index]) {
                                  _controller.resetSelections();
                                  _controller.selections[index] = true;
                                }
                              }),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16, top: 20),
              child: TextField(
                controller: _controller.nameText,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    labelText: "ADI",
                    labelStyle: Get.textTheme.bodyText2!
                        .copyWith(color: Get.theme.primaryColor),
                    border: OutlineInputBorder()),
              ),
            ),
            ExpandableTimeSelector(
                title: "Beslediğim Saatler",
                listTitle: "beslenme saati:",
                selectedTimes: _controller.feedingTimes,
                color: Get.theme.primaryColor),
            ExpandableTimeSelector(
                title: "Su Verdiğim Saatler",
                listTitle: "Su verme saati:",
                selectedTimes: _controller.waterTimes,
                color: Color(0xFF8BC3CA)),
            Obx(
                  () =>
                  Visibility(
                    visible: _controller.selections[0],
                    child: ExpandableTimeSelector(
                      title: "Gezdirdiğim Saatler",
                      listTitle: "Dışarı çıkma vakti:",
                      color: Colors.orange,
                      selectedTimes: _controller.walkingTimes,
                    ),
                  ),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Get.theme.primaryColor, elevation: 30),
                onPressed: () {},
                icon: Icon(Icons.add_circle_outline),
                label: Text("EKLE")),
          ],
        ));
  }
}
