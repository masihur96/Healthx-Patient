import 'package:flutter/material.dart';
import 'package:healthx_patient/shared/onboard_slider.dart';
import 'package:healthx_patient/shared/pref_key.dart';

import '../configs/custom_size.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PREFSKey prefs = PREFSKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const SizedBox(),
      body: Stack(
        children: [
          // Doctor image
          Image.asset(
            "assets/images/onboard.jpg",
            height: screenSize(context, 2),
            width: screenSize(context, 1),
            fit: BoxFit.cover,
          ),

          // Bottom card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenSize(context, 1),
              height: screenSize(context, .9),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: OnboardSlider(),
            ),
          ),
        ],
      ),
    );
  }
}
