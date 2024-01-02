import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:requester/controllers/request_controller.dart';
import 'package:requester/screens/main_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RequestController ctrl = Get.put(RequestController());
    ctrl.getData();
    return AnimatedSplashScreen(
      backgroundColor: Colors.black,
      duration: 2500,
      splash: Image.asset('assets/images/splash.png'),
      splashIconSize: Get.width / 2,
      nextScreen: MainScreen(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}
