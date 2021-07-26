import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/splash_screen/splash_screen_controller.dart';

class SplashScreenView extends StatelessWidget {
  final SplashScreenController _controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Get.theme.backgroundColor,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(120),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text("Pet Care",
                          style: GoogleFonts.pacifico(
                              fontSize: 48, color: Get.theme.primaryColor)),
                    ),
                    SizedBox(height: 10),
                    SpinKitPumpingHeart(
                        color: Get.theme.primaryColor, size: 35),
                    Obx(
                      () => Text(_controller.loadingText.value,
                          style: GoogleFonts.courgette(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
