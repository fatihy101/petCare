import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/sign_up/sign_up_controller.dart';
import 'package:pet_care/services/authentication.dart';
import 'package:pet_care/widgets/widgets.dart';

class SignUpView extends StatelessWidget {
  final SignUpController _controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await _controller.readPhotosFromAsset(context);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,
        title: Text("Kaydol", style: GoogleFonts.pacifico(fontSize: 28)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    color: Colors.grey.shade700,
                    elevation: 10,
                    child: ExpandableNotifier(
                        child: Expandable(
                          collapsed: ExpandableButton(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 5),
                                    child: Wrap(
                                      children: [
                                        Icon(
                                          Icons.mail,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Email ile kaydol",
                                          style: GoogleFonts.courgette(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    children: [
                                      Text(
                                        "Genişlet",
                                        style: Get.textTheme.bodyText2!
                                            .copyWith(
                                            fontSize: 16,
                                            color: Colors.white70),
                                      ),
                                      Icon(CupertinoIcons.chevron_down,
                                          color: Colors.white)
                                    ],
                                  ),
                                ],
                              )),
                          expanded: Form(
                            key: _controller.formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () => _controller.showAvatars(),
                                    child: Obx(() => CircleAvatar(
                                          backgroundImage: AssetImage(_controller.selectedAvatar.value),
                                          radius: 50,
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.grey.shade700),
                                    ),
                                  ),
                                ),
                                buildFormField(
                                    text: "E-posta",
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (!Authentication.isEmailValid(value!))
                                        return "Geçerli bir e-posta giriniz.";
                                    },
                                    controller: _controller.emailCtrl,
                                    icon: Icon(
                                      Icons.mail,
                                      color: Colors.white70,
                                    )),
                                buildFormField(
                                    text: "Ad Soyad",
                                    controller: _controller.nameSurnameCtrl,
                                    validator: (value) {
                                      if (value == "" || value == null) {
                                        return "Ad soyadınızı yazınız";
                                      }
                                    },
                                    icon: Icon(
                                      Icons.info,
                                      color: Colors.white70,
                                    )),
                                buildFormField(
                                    text: "Parola",
                                    controller: _controller.passwordCtrl,
                                    validator: (value) {
                                      if (value == null || value == "")
                                        return "Parolanızı yazınız";
                                      if (value.length < 6)
                                        return "Parolanız 6 karakterden kısa olamaz";
                                    },
                                    obscureText: true,
                                    icon: Icon(
                                        Icons.lock, color: Colors.white70)),
                                buildFormField(
                                    text: "Parola Tekrar",
                                    validator: (value) {
                                      if (value == null || value == "")
                                        return "Parolanızı tekrar yazınız";
                                      if (value !=
                                          _controller.passwordCtrl.text)
                                        return "Parola ve tekrarı uyuşmuyor";
                                    },
                                    controller: _controller.passwordReCtrl,
                                    obscureText: true,
                                    icon: Icon(
                                        Icons.lock, color: Colors.white70)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: BlockIconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      bool success = await _controller.submitEmailPass();
                                      if (success) {
                                        Get.back();
                                      }
                                    },
                                    icon: Icon(
                                      Icons.check_circle,
                                      color: Colors.black54,
                                    ),
                                    textWidget: Text(
                                      "Kaydol",
                                      style: Get.textTheme.bodyText2!
                                          .copyWith(color: Colors.black54),
                                    ),
                                  ),
                                ),
                                ExpandableButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 12.0, bottom: 20),
                                    child: Column(
                                      children: [
                                        Icon(CupertinoIcons.chevron_up,
                                            color: Colors.white60),
                                        Text(
                                          "Küçült",
                                          style: Get.textTheme.bodyText2!
                                              .copyWith(
                                              fontSize: 16,
                                              color: Colors.white70),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: BlockIconButton(
                      onPressed: null,
                      color: Get.theme.primaryColor,
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                      text: "Google ile Kaydol"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFormField({required String text,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool obscureText = false,
    Widget? icon}) =>
      Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: Get.theme.backgroundColor,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade300),
                  borderRadius: BorderRadius.circular(30)),
              errorStyle: TextStyle(color: Colors.white),
              suffixIcon: icon,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(30)),
              labelText: text,
              labelStyle:
              GoogleFonts.courgette(fontSize: 20, color: Colors.white),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Get.theme.backgroundColor),
                  borderRadius: BorderRadius.circular(10)),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
      );
}
