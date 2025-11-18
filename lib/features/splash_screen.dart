import 'package:flutter/material.dart';
import 'package:healthx_patient/shared/pref_key.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import 'on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PREFSKey prefs = PREFSKey();
  final updater = ShorebirdUpdater();

  @override
  void initState() {
    super.initState();
    _checkForUpdates();
    navigateToNext();
  }

  Future<void> _checkForUpdates() async {
    // Check whether a new update is available.
    final status = await updater.checkForUpdate();

    if (status == UpdateStatus.outdated) {
      try {
        // Perform the update
        await updater.update();
      } on UpdateException catch (error) {
        // Handle any errors that occur while updating.
      }
    }
  }

  navigateToNext() async {
    await Future.delayed(Duration(seconds: 3));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) =>
                OnBoardingScreen()), // Replace BottomNavScreen with your desired screen
        (Route<dynamic> route) => false,
      );

      // final AuthTokenModel? authTokenModel = await StorageService.getAuthData();
      //
      // if (authTokenModel == null) {
      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //         builder: (_) =>
      //             OnBoardingScreen()), // Replace BottomNavScreen with your desired screen
      //     (Route<dynamic> route) => false,
      //   );
      // } else {
      //   bool hasExpired = JwtDecoder.isExpired(authTokenModel.access);
      //   if (hasExpired) {
      //     Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(
      //           builder: (_) =>
      //               OnBoardingScreen()), // Replace BottomNavScreen with your desired screen
      //       (Route<dynamic> route) => false,
      //     );
      //   } else {
      //     await context
      //         .read<AuthViewModel>()
      //         .fetchProfile(accessToken: authTokenModel.access);
      //
      //     Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(
      //           builder: (_) =>
      //               BottomNavScreen()), // Replace BottomNavScreen with your desired screen
      //       (Route<dynamic> route) => false,
      //     );
      //   }
      // }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(),
      body: Center(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // adjust radius as needed
        child: Image.asset(
          'assets/icon/icon.jpeg',
          width: 120,
          height: 120,
          fit: BoxFit.cover, // keeps the image filled properly
        ),
      )),
    );
  }
}
