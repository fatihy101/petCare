import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/login/login_controller.dart';
import 'package:pet_care/services/authentication.dart';
import 'package:pet_care/widgets/widgets.dart';

class LoginView extends StatelessWidget {
  final LoginController _controller = Get.find();
  final Authentication _authentication = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller.emailController,
                cursorColor: Get.theme.primaryColor,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "E-posta",
                    labelStyle: GoogleFonts.courgette(
                        fontSize: 20, color: Get.theme.primaryColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _controller.passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Parola",
                    labelStyle: GoogleFonts.courgette(
                        fontSize: 20, color: Get.theme.primaryColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              Container(
                  padding: EdgeInsets.only(top: 5),
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Text(
                    "Parolamı unuttum",
                    style: GoogleFonts.courgette(
                        color: Get.theme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 15),
              BlockIconButton(
                  onPressed: () {
                    Get.back();
                  },
                  color: Colors.black,
                  icon: Icon(
                    Icons.mail_outline,
                    color: Colors.white,
                  ),
                  text: "Giriş Yap"),
              SizedBox(height: 10),
              BlockIconButton(
                  onPressed: () async {
                    await _authentication.signInWithGoogle();
                    Get.back();
                  },
                  color: Get.theme.primaryColor,
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                  text: "Google ile Giriş Yap"),
              Container(
                  padding: EdgeInsets.only(top: 35),
                  child: Text(
                    "Üye değil misin? Hemen üye ol!",
                    style: GoogleFonts.courgette(
                        color: Get.theme.primaryColor.withOpacity(0.9),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
