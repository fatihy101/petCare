import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/home/home_controller.dart';
import 'package:pet_care/pages/login/login_view.dart';
import 'package:pet_care/pages/pet_information/pet_information_view.dart';
import 'package:pet_care/pages/user_profile/user_profile_view.dart';
import 'package:pet_care/services/authentication.dart';
import 'package:pet_care/services/pet_service.dart';
import 'package:pet_care/services/user_service.dart';
import 'package:pet_care/widgets/custom_snackbar.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomeView extends StatelessWidget {
  final HomeController _controller = Get.find();
  final Authentication _authentication = Get.find();
  final UserService _userService = Get.find();
  final PetService _petService = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white70,
              ),
              onPressed: null),
          title: Obx(
            () => InkWell(
                onLongPress: _authentication.isUserSignedIn.value
                    ? () {
                        _authentication.signOut();
                        CustomSnackBar.getSnackBar(
                            "Çıkış başarılı", "Easter-egg");
                      }
                    : null,
                child: Text("Pet Care",
                    style: GoogleFonts.pacifico(fontSize: 28))),
          ),
          actions: [
            Obx(
              () => !_authentication.isUserSignedIn.value
                  ? IconButton(
                      icon: Icon(CupertinoIcons.profile_circled,
                          color: Colors.white70),
                      onPressed: () => Get.bottomSheet(LoginView()))
                  : Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () => Get.bottomSheet(UserProfileView()),
                        child: _userService.petOwner.value != null
                            ? CircleAvatar(
                                backgroundImage: _userService
                                            .petOwner.value!.photoURL !=
                                        null
                                    ? NetworkImage(
                                        _userService.petOwner.value!.photoURL!)
                                    : AssetImage(_userService.petOwner.value!
                                        .avatarName!) as ImageProvider,
                              )
                            : SpinKitCircle(
                                color: Colors.white,
                              ),
                      ),
                    ),
            )
          ],
          bottom: _controller.isTabView()
              ? TabBar(
                  isScrollable: true,
                  physics: BouncingScrollPhysics(),
                  tabs: _controller.tabs,
                  indicator: RectangularIndicator(
                      bottomLeftRadius: 60,
                      bottomRightRadius: 60,
                      topLeftRadius: 40,
                      topRightRadius: 40,
                      color: Colors.black.withOpacity(0.2)),
                )
              : null,
        ),
        floatingActionButton: FloatingActionButton(
          child: FaIcon(
            FontAwesomeIcons.paw,
            color: Colors.white70,
          ),
          onPressed: () => Get.toNamed("/add_pet"),
          backgroundColor: Get.theme.primaryColor,
          elevation: 5,
          splashColor: Get.theme.backgroundColor,
        ),
        body: Obx(
          () => Center(
            child: _controller.isTabView()
                ? TabBarView(
                    children: _controller.tabViews,
                  )
                : (_petService.pets.length == 1
                    ? PetInformationView(pet: _petService.pets[0])
                    : Container(
                        child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Evcil hayvanınızı eklemek için ",
                              style: Get.textTheme.bodyText2!
                                  .copyWith(color: Colors.black)),
                          WidgetSpan(
                              child: FaIcon(FontAwesomeIcons.paw,
                                  color: Get.theme.primaryColor)),
                          TextSpan(
                              text: "'ye tıklayınız.",
                              style: Get.textTheme.bodyText2!
                                  .copyWith(color: Colors.black)),
                        ]),
                      ))),
          ),
        ),
      ),
    );
  }
}
