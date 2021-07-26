import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/home/home_controller.dart';
import 'package:pet_care/pages/login/login_view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomeView extends StatelessWidget {
  final HomeController _controller = Get.find();

  Tab createTab(String petName, bool isDog) => Tab(
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child:
            FaIcon(isDog ? FontAwesomeIcons.dog  : FontAwesomeIcons.cat, color: Get.theme.backgroundColor),
          ),
          Text(
            petName,
            style: GoogleFonts.courgette(
                color: Get.theme.backgroundColor,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
        ]),
  );

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
          title: Text("Pet Care", style: GoogleFonts.pacifico(fontSize: 28)),
          actions: [
            IconButton(
                icon: Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.white70,
                ),
                onPressed: () => Get.bottomSheet(LoginView()))
          ],
          bottom: TabBar(
            isScrollable: true,
            physics: BouncingScrollPhysics(),
            tabs: [
              createTab("Lisa", true),
              createTab("Pisi", false)
            ],
            indicator: RectangularIndicator(
              bottomLeftRadius: 60,
              bottomRightRadius: 60,
              topLeftRadius: 40,
              topRightRadius: 40,

              color: Colors.black.withOpacity(0.2)
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: FaIcon(
            FontAwesomeIcons.paw,
            color: Colors.white70,
          ),
          onPressed: () {},
          backgroundColor: Get.theme.primaryColor,
          elevation: 5,
          splashColor: Get.theme.backgroundColor,
        ),
        body: Center(
          child: TabBarView(
            children: [Icon(Icons.animation), Icon(Icons.animation)],
          ),
        ),
      ),
    );
  }
}
