import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/custom_theme.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';

import '../../data/models/appointment_model.dart';
import 'status_badge_widget.dart';

class AppointmentCardWidget extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback? onTap;
  final VoidCallback? onReschedule;
  final VoidCallback? onCancel;
  final bool showActions;

  const AppointmentCardWidget({
    super.key,
    required this.appointment,
    this.onTap,
    this.onReschedule,
    this.onCancel,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final canReschedule = appointment.status == AppointmentStatus.confirmed ||
        appointment.status == AppointmentStatus.pending;
    final canCancel = appointment.status == AppointmentStatus.confirmed ||
        appointment.status == AppointmentStatus.pending;

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: boxStyle(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Provider photo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      appointment.providerPhoto,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.person, size: 30),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Provider info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.providerName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              _getTypeIcon(),
                              size: 14,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${appointment.type.displayName} • ${appointment.specialty}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Status badge
                  StatusBadgeWidget(status: appointment.status),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              // Date and time
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppColors.buttonColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(appointment.date),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppColors.buttonColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    appointment.time,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              // Location/Consultation type
              if (appointment.location != null ||
                  appointment.consultationType == ConsultationType.online) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      appointment.consultationType == ConsultationType.online
                          ? Icons.video_call
                          : Icons.location_on,
                      size: 16,
                      color: AppColors.buttonColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        appointment.consultationType == ConsultationType.online
                            ? 'Online Video Consultation'
                            : appointment.location ?? 'In-person',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
              // Action buttons
              if (showActions && (canReschedule || canCancel)) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (canReschedule) ...[
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onReschedule,
                          icon: const Icon(Icons.schedule,
                              color: AppColors.white, size: 16),
                          label: const Text('Reschedule'),
                          style: OutlinedButton.styleFrom(
                            side:
                                const BorderSide(color: AppColors.buttonColor),
                            foregroundColor: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (canCancel)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onCancel,
                          icon: const Icon(Icons.close,
                              color: AppColors.white, size: 16),
                          label: const Text('Cancel'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.red),
                            foregroundColor: AppColors.white,
                            backgroundColor: AppColors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTypeIcon() {
    switch (appointment.type) {
      case AppointmentType.doctor:
        return Icons.local_hospital;
      case AppointmentType.lab:
        return Icons.science;
      case AppointmentType.specialist:
        return Icons.medical_services;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }
}
