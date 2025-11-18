import 'package:flutter/material.dart';
import 'package:healthx_patient/features/auth/presentation/views/login_screen.dart';
import 'package:healthx_patient/features/auth/presentation/views/registration_screen.dart';
import 'package:healthx_patient/features/splash_screen.dart';
import 'package:healthx_patient/features/doctor/presentation/views/doctor_detail_screen.dart';
import 'package:healthx_patient/features/doctor/presentation/views/booking_confirmation_screen.dart';

class RouteGenerator {
  static const String loginRoute = '/login';
  static const String logoutRoute = '/logout';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home'; // ✅ Add this
  static const String splashRoute = '/'; // ✅ Add this
  static const String doctorDetailRoute = '/doctor/detail';
  static const String bookingConfirmationRoute = '/doctor/booking-confirmation';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case logoutRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());

      // case homeRoute: // ✅ Add this case
      //   return MaterialPageRoute(builder: (_) => BottomNavScreen(w));

      case doctorDetailRoute:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => DoctorDetailScreen(doctor: args),
        );

      case bookingConfirmationRoute:
        final payload = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => BookingConfirmationScreen(payload: payload),
        );

      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
