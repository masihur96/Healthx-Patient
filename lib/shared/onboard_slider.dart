import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/custom_size.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/features/auth/presentation/views/login_screen.dart';

class OnboardSlider extends StatefulWidget {
  const OnboardSlider({super.key});

  @override
  State<OnboardSlider> createState() => _OnboardSliderState();
}

class _OnboardSliderState extends State<OnboardSlider> {
  final PageController _controller = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  final List<String> titles = [
    "More Comfortable Chat\nWith the Doctor",
    "Easy Booking System\nFor Consultation",
    "Stay Healthy\nWith Regular Advice",
  ];

  final List<String> subtitles = [
    "Book an appointment with doctor. Chat\nwith doctor via appointment letter and get\nconsultationt.",
    "Get appointments with a few taps — no\nhassle, no wait.",
    "Consult doctors and track your health\nwith regular updates.",
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: titles.length,
      onPageChanged: (index) => setState(() => _currentPage = index),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(
                titles[_currentPage],
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors
                          .blueAccent, // Replace with MediCareProColor.buttonColor
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize(context, .07),
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                subtitles[_currentPage],
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.grey[600],
                      fontSize: screenSize(context, .04),
                    ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              // Dynamic indicator dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(titles.length, (index) {
                  bool isActive = _currentPage == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < titles.length - 1) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentPage == titles.length - 1 ? "Get Started" : "Next",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
