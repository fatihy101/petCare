import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/pages/home/home_bindings.dart';
import 'package:pet_care/pages/login/login_view.dart';
import 'package:pet_care/pages/splash_screen/splash_screen_view.dart';
import 'package:pet_care/pages/home/home_view.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      transitionDuration: Duration(milliseconds: 800),
      theme: Themes.lightTheme,
      themeMode: ThemeMode.light,
      defaultTransition: Transition.leftToRightWithFade,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => SplashScreenView()),
        GetPage(name: "/login", page: () =>  LoginView()),
        GetPage(name: "/home", page: () => HomeView(), binding: HomeBindings())
      ],
    );
  }
}

class Themes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    backgroundColor: Color(0xFFFFC2AD),
    primaryColor:Colors.red.shade400,
    primaryColorDark: Colors.red.shade500,
    accentColor: Color(0xFFABE3EA)
  );
}
