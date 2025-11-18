import 'package:flutter/material.dart';
import 'package:healthx_patient/features/auth/presentation/views/login_screen.dart';

class VerificationSuccessfulScreen extends StatelessWidget {
  final String title;
  final String subTitle;
  const VerificationSuccessfulScreen(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF268AFF), // Blue background
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            // Checkmark in a circle
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(40),
              child: const Icon(
                Icons.check,
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            // Title
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Subtitle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                subTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(flex: 3),
            // Get Started Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                    // TODO: Add navigation or action
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Color(0xFF268AFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// XKtiq0
