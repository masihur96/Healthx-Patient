import 'package:flutter/material.dart';
import 'package:healthx_patient/features/auth/presentation/views/login_screen.dart';
import 'package:healthx_patient/features/auth/presentation/views/registration_screen.dart';
import 'package:healthx_patient/features/splash_screen.dart';
import 'package:healthx_patient/features/doctor/presentation/views/doctor_detail_screen.dart';
import 'package:healthx_patient/features/doctor/presentation/views/booking_confirmation_screen.dart';
import 'package:healthx_patient/features/appointment/presentation/views/appointment_screen.dart';
import 'package:healthx_patient/features/appointment/presentation/views/provider_selection_screen.dart';
import 'package:healthx_patient/features/appointment/presentation/views/datetime_selection_screen.dart';
import 'package:healthx_patient/features/appointment/presentation/views/appointment_confirmation_screen.dart';
import 'package:healthx_patient/features/appointment/presentation/views/appointment_success_screen.dart';
import 'package:healthx_patient/features/appointment/presentation/views/appointment_management_screen.dart';
import 'package:healthx_patient/features/appointment/data/models/appointment_model.dart';

class RouteGenerator {
  static const String loginRoute = '/login';
  static const String logoutRoute = '/logout';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String splashRoute = '/';
  static const String doctorDetailRoute = '/doctor/detail';
  static const String bookingConfirmationRoute = '/doctor/booking-confirmation';
  
  // Appointment routes
  static const String appointmentHomeRoute = '/appointments';
  static const String providerSelectionRoute = '/appointments/provider-selection';
  static const String datetimeSelectionRoute = '/appointments/datetime-selection';
  static const String appointmentConfirmationRoute = '/appointments/confirmation';
  static const String appointmentSuccessRoute = '/appointments/success';
  static const String appointmentManagementRoute = '/appointments/management';

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

      case appointmentHomeRoute:
        return MaterialPageRoute(builder: (_) => const AppointmentScreen());

      case providerSelectionRoute:
        return MaterialPageRoute(builder: (_) => const ProviderSelectionScreen());

      case datetimeSelectionRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => DateTimeSelectionScreen(arguments: args),
        );

      case appointmentConfirmationRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => AppointmentConfirmationScreen(arguments: args),
        );

      case appointmentSuccessRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => AppointmentSuccessScreen(arguments: args),
        );

      case appointmentManagementRoute:
        final appointment = settings.arguments as Appointment;
        return MaterialPageRoute(
          builder: (_) => AppointmentManagementScreen(appointment: appointment),
        );

      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
