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
                validator: (value) {
                  if (!Authentication.isEmailValid(value!))
                    return "Geçerli bir e-posta giriniz.";
                },
                onChanged: _controller.setSubmitOnChange,
                style: TextStyle(color: Colors.black),
                controller: _controller.emailController,
                cursorColor: Get.theme.primaryColor,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "E-posta",
                    labelStyle: GoogleFonts.courgette(
                        fontSize: 20, color: Get.theme.primaryColor),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Get.theme.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100))),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: _controller.setSubmitOnChange,
                style: TextStyle(color: Colors.black),
                controller: _controller.passwordController,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: Get.theme.primaryColor,
                validator: (value) {
                  if (value!.length < 8)
                    return "Parolanız 8 karakterden uzun olmalı.";
                },
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Parola",
                    labelStyle: GoogleFonts.courgette(
                        fontSize: 20, color: Get.theme.primaryColor),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Get.theme.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
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
              Obx(
                () => BlockIconButton(
                  onPressed: _controller.submitEnabled.value
                      ? () {
                          _controller.submit();
                          //Get.back();
                        }
                      : null,
                  color: _controller.submitEnabled.value
                      ? Colors.black
                      : Colors.grey.shade200,
                  icon: Icon(
                    Icons.mail_outline,
                    color: _controller.submitEnabled.value
                        ? Colors.white
                        : Colors.black,
                  ),
                  textWidget: Text("Giriş Yap",
                      style: GoogleFonts.courgette(
                          fontSize: 20,
                          color: _controller.submitEnabled.value
                              ? Colors.white
                              : Colors.black)),
                ),
              ),
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
              InkWell(
                onTap: () => Get.toNamed("sign_up"),
                child: Container(
                    padding: EdgeInsets.only(top: 35),
                    child: Text(
                      "Üye değil misin? Hemen üye ol!",
                      style: GoogleFonts.courgette(
                          color: Get.theme.primaryColor.withOpacity(0.9),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
