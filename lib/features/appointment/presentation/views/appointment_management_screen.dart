import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/custom_theme.dart';
import 'package:healthx_patient/configs/route_generator.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';

import '../../data/models/appointment_model.dart';
import '../widgets/status_badge_widget.dart';

class AppointmentManagementScreen extends StatelessWidget {
  final Appointment appointment;

  const AppointmentManagementScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final canReschedule = appointment.status == AppointmentStatus.confirmed ||
        appointment.status == AppointmentStatus.pending;
    final canCancel = appointment.status == AppointmentStatus.confirmed ||
        appointment.status == AppointmentStatus.pending;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_outlined)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Provider Card
            Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: boxStyle(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            appointment.providerPhoto,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.person, size: 40),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appointment.providerName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                appointment.specialty,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              StatusBadgeWidget(status: appointment.status),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Appointment Details
            const Text(
              'Appointment Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: boxStyle(),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.calendar_today,
                      label: 'Date',
                      value: _formatDate(appointment.date),
                    ),
                    const Divider(height: 1),
                    _InfoRow(
                      icon: Icons.access_time,
                      label: 'Time',
                      value: appointment.time,
                    ),
                    const Divider(height: 1),
                    _InfoRow(
                      icon: appointment.consultationType ==
                              ConsultationType.online
                          ? Icons.video_call
                          : Icons.location_on,
                      label: 'Type',
                      value: appointment.consultationType.displayName,
                    ),
                    if (appointment.location != null) ...[
                      const Divider(height: 1),
                      _InfoRow(
                        icon: Icons.place,
                        label: 'Location',
                        value: appointment.location!,
                      ),
                    ],
                    const Divider(height: 1),
                    _InfoRow(
                      icon: Icons.payments,
                      label: 'Fee',
                      value: '৳${appointment.fee.toStringAsFixed(0)}',
                    ),
                    const Divider(height: 1),
                    _InfoRow(
                      icon: Icons.confirmation_number,
                      label: 'Appointment ID',
                      value: appointment.appointmentId,
                      valueColor: AppColors.buttonColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Action Buttons
            if (canReschedule || canCancel) ...[
              if (canReschedule)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.of(context).pushNamed(
                        RouteGenerator.datetimeSelectionRoute,
                        arguments: {
                          'appointment': appointment,
                          'isReschedule': true,
                        },
                      );

                      if (result == true && context.mounted) {
                        Navigator.of(context).pop(true);
                      }
                    },
                    icon: const Icon(Icons.schedule, color: Colors.white),
                    label: const Text(
                      'Reschedule Appointment',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              if (canReschedule && canCancel) const SizedBox(height: 12),
              if (canCancel)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cancel Appointment'),
                          content: const Text(
                            'Are you sure you want to cancel this appointment? This action cannot be undone.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('No, Keep It'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text(
                                'Yes, Cancel',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (confirmed == true && context.mounted) {
                        // Show cancellation success
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Appointment cancelled successfully'),
                          ),
                        );
                        Navigator.of(context).pop(true);
                      }
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.white,
                    ),
                    label: const Text('Cancel Appointment'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.red),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
            ] else ...[
              Center(
                child: Text(
                  appointment.status == AppointmentStatus.completed
                      ? 'This appointment has been completed'
                      : 'This appointment has been cancelled',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return '${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.buttonColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
