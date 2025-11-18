import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';

class LoadingPlaceHolder extends StatelessWidget {
  const LoadingPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 208.0),
        child: Image.asset('assets/animations/loading.gif',
            repeat: ImageRepeat.repeat,
            color: AppColors.yellow,
            // height: screenSize(context, .2),
            // width: screenSize(context, 1),
            fit: BoxFit.fitWidth),
      ),
    );
  }
}
