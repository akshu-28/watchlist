import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/constants/app_constants.dart';
import 'package:watchlist/constants/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Color baseColor = const Color(0xFFf2f2f2);
  double firstDepth = 50;
  double secondDepth = 50;
  double thirdDepth = 50;
  double fourthDepth = 50;
  double fifthDepth = 50;
  double sixthDepth = 50;
  late AnimationController _animationController;

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => navigationPage(),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addListener(() {});

    controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animation = Tween<double>(begin: 50, end: 300).animate(controller)
      ..addListener(() {});
    controller.forward();
    _animationController.forward();
  }

  void navigationPage() {
     Navigator.pushReplacementNamed(context, RouteName.registerScreen);
  }

  @override
  void dispose() {
    controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.green[200]!,
          Colors.white,
        ],
      )),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/assets/logo_icon.png",
                  width: 70,
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 30.0,
                      fontFamily: "horizon",
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(AppConstants.watchlistTitle),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
