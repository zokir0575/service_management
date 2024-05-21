import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_images.dart';
import 'package:service_app/modules/navigation/presentation/home.dart';
import 'package:service_app/modules/navigation/presentation/navigator.dart';
import 'package:service_app/modules/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:service_app/utils/storage.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({ super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
     StorageRepository.getBool('registered')
          ? Navigator.pushReplacement(context, fade(page: NavigationScreen()))
          : Navigator.pushReplacement(context, fade(page: OnBoardingScreen()));
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
                  height: 200,
                  width: 200,
                  AppImages.logo)),
             Positioned(
                bottom: 20 + MediaQuery.of(context).padding.bottom,
                right: 0,
                left: 0,
                child: const   Column(
                  children: [
                    CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ],
                ))
        ],
      ),
    );
  }
}
