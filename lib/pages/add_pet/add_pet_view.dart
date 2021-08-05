import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pet_care/pages/add_pet/add_pet_controller.dart';
import 'package:pet_care/pages/add_pet/expandable_time_selector.dart';
import 'package:pet_care/extensions/conversions.dart';
import 'package:pet_care/widgets/block_icon_button.dart';
import 'package:pet_care/widgets/custom_snackbar.dart';

class AddPetView extends StatefulWidget {
  @override
  _AddPetViewState createState() => _AddPetViewState();
}

class _AddPetViewState extends State<AddPetView> {
  final AddPetController _controller = Get.put(AddPetController());
  DateTime now = DateTime.now();

  DateTime? birthdayDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        confirmText: "TAMAM",
        cancelText: "İPTAL",
        initialDate: now,
        firstDate: DateTime(1990, 1),
        lastDate: now.add(Duration(days: 1)));

    setState(() {
      birthdayDate = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Evcil Hayvan Ekle",
              style: Get.theme.appBarTheme.titleTextStyle),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                        () => ToggleButtons(
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
                  style: Get.textTheme.bodyText2!
                      .copyWith(color: Colors.black, fontSize: 20),
                  decoration: InputDecoration(
                      labelText: "ADI",
                      labelStyle: Get.textTheme.bodyText2!
                          .copyWith(color: Get.theme.primaryColor),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, top: 20),
                child: TextField(
                  controller: _controller.breedText,
                  style: Get.textTheme.bodyText2!
                      .copyWith(color: Colors.black, fontSize: 20),
                  decoration: InputDecoration(
                      labelText: "CİNSİ",
                      labelStyle: Get.textTheme.bodyText2!
                          .copyWith(color: Get.theme.primaryColor),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, left: 16, top: 20,bottom: 10),
                child: InkWell(
                  onTap: () => selectDate(context),
                  child: IgnorePointer(
                    child: TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: birthdayDate != null
                              ? birthdayDate!.withoutHourString()
                              : ""),
                      style: Get.textTheme.bodyText2!
                          .copyWith(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                          labelText: "DOĞUM TARİHİ",
                          labelStyle: Get.textTheme.bodyText2!
                              .copyWith(color: Get.theme.primaryColor),
                          border: OutlineInputBorder()),
                    ),
                  ),
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
                () => Visibility(
                  visible: _controller.selections[0],
                  child: ExpandableTimeSelector(
                    title: "Gezdirdiğim Saatler",
                    listTitle: "Dışarı çıkma vakti:",
                    color: Colors.orange,
                    selectedTimes: _controller.walkingTimes,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,  vertical: 20),
                child: BlockIconButton(
                    textWidget: Text("EKLE"),
                    onPressed: () {
                      if(birthdayDate != null) {
                        _controller.savePet(birthdayDate!);
                      } else {
                        CustomSnackBar.getSnackBar("Doğum tarihini giriniz", "Bir doğum tarihi belirtiniz");
                      }
                    },
                    icon: Icon(Icons.add_circle_outline),
                    color: Get.theme.primaryColor),
              ),
            ],
          ),
        ));
  }
}
