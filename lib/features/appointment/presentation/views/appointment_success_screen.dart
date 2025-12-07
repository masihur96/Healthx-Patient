import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/route_generator.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import '../../data/models/appointment_model.dart';
import '../widgets/appointment_summary_widget.dart';

class AppointmentSuccessScreen extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const AppointmentSuccessScreen({super.key, this.arguments});

  @override
  State<AppointmentSuccessScreen> createState() =>
      _AppointmentSuccessScreenState();
}

class _AppointmentSuccessScreenState extends State<AppointmentSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _setReminder = false;
  Appointment? _appointment;
  bool _isReschedule = false;
  String? _appointmentId;

  @override
  void initState() {
    super.initState();
    
    if (widget.arguments != null) {
      _appointment = widget.arguments!['appointment'];
      _isReschedule = widget.arguments!['isReschedule'] ?? false;
      _appointmentId = widget.arguments!['appointmentId'];
    }

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text('Success'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Success Animation
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.green.shade600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Success Message
            Text(
              _isReschedule
                  ? 'Appointment Rescheduled!'
                  : 'Your appointment has been confirmed!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isReschedule
                  ? 'Your appointment has been successfully rescheduled. We have sent the updated details to your phone and email.'
                  : 'We have sent the details to your phone and email.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            // Appointment Summary
            if (_appointment != null)
              AppointmentSummaryWidget(appointment: _appointment!)
            else
              Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.assignment_turned_in,
                        size: 48,
                        color: AppColors.buttonColor,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Appointment ID: ${_appointmentId ?? "N/A"}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20),
            // Actions
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.calendar_today,
                      color: AppColors.buttonColor,
                    ),
                    title: const Text('Add to Calendar'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Show calendar options
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Add to Calendar'),
                          content: const Text(
                            'This feature will export the appointment to your device calendar.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    value: _setReminder,
                    onChanged: (value) {
                      setState(() => _setReminder = value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            value
                                ? 'Reminder has been set for this appointment'
                                : 'Reminder has been removed',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    secondary: const Icon(
                      Icons.notifications_active,
                      color: AppColors.buttonColor,
                    ),
                    title: const Text('Set Reminder'),
                    subtitle: const Text('Get notified before appointment'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Go to Appointments Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteGenerator.appointmentHomeRoute,
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Go to My Appointments',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteGenerator.homeRoute,
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.buttonColor),
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
