import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_utibu_health_app/screens/onboarding_screens/onboardingscreen.dart';
import 'package:new_utibu_health_app/screens/other_screens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(Duration(seconds: 4), () {
      // Navigate to HomeScreen
      Get.toNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/advert4.png",
                width: 250,
              ),
            ),
          ),
          // Second animation
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Text("Welcome to Utibu App"),
            ),
          )
        ],
      ),
    );
  }
}
