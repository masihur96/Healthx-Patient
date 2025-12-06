import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';

class MediCareProButton extends StatelessWidget {
  final String title;
  final double height;
  final double width;

  final bool isLoading;

  final Color bgColor;
  final Function() onTap;
  const MediCareProButton({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    required this.bgColor,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        //set border radius more than 50% of height and width to make circle
      ),
      child: isLoading
          ? Center(
              child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ))
          : GestureDetector(
              onTap: onTap,
              child: Container(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
