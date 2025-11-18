import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    final messenger = ScaffoldMessenger.of(context);

    // 🔹 remove any currently showing snackbar immediately
    messenger.removeCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icon/icon.jpeg', // Replace with your logo
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(child: Text(message)),
          ],
        ),
        duration: duration,
        behavior: SnackBarBehavior.floating, // looks cleaner
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

String capitalizeFirst(String s) =>
    s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : '';
