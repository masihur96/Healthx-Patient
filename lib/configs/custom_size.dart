import 'package:flutter/material.dart';

double screenSize(BuildContext context, double partialSize) {
  var screenSize = MediaQuery.of(context).size.width;
  return screenSize * partialSize;
}

// double screenSize(BuildContext context, double baseValue) {
//   final double screenWidth = MediaQuery.of(context).size.width;
//   double scaleFactor;
//
//   if (screenWidth >= 1200) {
//     // Desktop and larger screens
//     scaleFactor = 1.5;
//   } else if (screenWidth >= 600) {
//     // Tablet screens
//     scaleFactor = 1.2;
//   } else {
//     // Mobile screens
//     scaleFactor = 1.0;
//   }
//
//   return baseValue * scaleFactor;
// }
