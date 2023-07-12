import 'dart:async';

import 'package:apna_khata/Greeting_screens/Onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(
          seconds: 4,
        ), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnBoardingScreen(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: Image(
          height: 300,
          width: 300,
          image: AssetImage("assets/SplashLogo.jpeg"),
        ),
      ),
    );
  }
}
