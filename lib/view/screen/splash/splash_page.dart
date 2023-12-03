import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ye_airways/shared/components/constantes.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:ye_airways/view/screen/main_ye_screen.dart';
import 'package:ye_airways/view/screen/splash/get_started.dart';

class SplashHome extends StatelessWidget {
  static const String id = 'splash_YE_Screen';

  const SplashHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          child: AnimatedSplashScreen(
              centered: true,
              splashIconSize: 300,
              duration: 300,
              splash: Container(
                child: Image.asset("assets/icon_plane.png"),
              ),
              nextScreen: uid != "" ? Main_YE_Screen() : const GetStartedPage(),
              splashTransition: SplashTransition.rotationTransition,
              // pageTransitionType: PageTransitionType.hashCode,
              backgroundColor: kPrimaryColor),
        ),
      ),
    );
  }
}
