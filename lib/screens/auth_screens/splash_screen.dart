import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel/helpers/constants.dart';
import 'package:marvel/helpers/get_size.dart';
import 'package:marvel/screens/auth_screens/login_screen.dart';
import 'package:marvel/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
          child: Image.asset(
        "assets/InvertedLogo.png",
        width: getSize(context).width * 0.8,
      )),
    );
  }
}
