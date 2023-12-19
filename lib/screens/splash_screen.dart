import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:requester/screens/homepage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //SplashServices.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.black,
      duration: 3500,
      splash: Image.asset('assets/images/splash.png'),
      splashIconSize: Get.width / 2,
      nextScreen: HomePage(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}

/* Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Заявки и исполнения',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lobster',
                fontSize: 30,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xff151414),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        offset: const Offset(1, 1)),
                    BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        offset: const Offset(-1, -1))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/splash.png'),
              ),
            ),
          ],
        ),
      ),
    ); */