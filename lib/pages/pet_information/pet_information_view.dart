import 'package:flutter/material.dart';
import 'package:pet_care/models/pet.dart';
import 'package:pet_care/widgets/profile_row.dart';
import 'package:pet_care/extensions/conversions.dart';

class PetInformationView extends StatefulWidget {
  final Pet pet;

  const PetInformationView({Key? key, required this.pet}) : super(key: key);

  @override
  _PetInformationViewState createState() => _PetInformationViewState();
}

class _PetInformationViewState extends State<PetInformationView> {
  late Pet pet;

  @override
  void initState() {
    super.initState();
    pet = widget.pet;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ProfileRow(headline: "ADI", text: pet.name, flexIt: false),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileRow(headline: "TÜRÜ", text: pet.breed!, flexIt: false),
              Visibility(
                visible: pet.birthdayDate != null,
                child: ProfileRow(
                    headline: "DOĞUM TARİHİ",
                    text: pet.birthdayDate!.withoutHourString(),
                    flexIt: false),
              ),
            ],
          )
        ],
      )),
    );
  }
}
