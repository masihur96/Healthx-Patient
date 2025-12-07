import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/custom_theme.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import '../../data/models/appointment_model.dart';

class AppointmentSummaryWidget extends StatelessWidget {
  final Appointment appointment;

  const AppointmentSummaryWidget({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: boxStyle(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Appointment Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            // Provider
            _SummaryRow(
              icon: Icons.person,
              label: 'Provider',
              value: appointment.providerName,
            ),
            const SizedBox(height: 12),
            // Specialty
            _SummaryRow(
              icon: Icons.medical_services,
              label: 'Specialty',
              value: appointment.specialty,
            ),
            const SizedBox(height: 12),
            // Date
            _SummaryRow(
              icon: Icons.calendar_today,
              label: 'Date',
              value: _formatDate(appointment.date),
            ),
            const SizedBox(height: 12),
            // Time
            _SummaryRow(
              icon: Icons.access_time,
              label: 'Time',
              value: appointment.time,
            ),
            const SizedBox(height: 12),
            // Type
            _SummaryRow(
              icon: appointment.consultationType == ConsultationType.online
                  ? Icons.video_call
                  : Icons.location_on,
              label: 'Type',
              value: appointment.consultationType.displayName,
            ),
            if (appointment.location != null) ...[
              const SizedBox(height: 12),
              _SummaryRow(
                icon: Icons.place,
                label: 'Location',
                value: appointment.location!,
              ),
            ],
            const SizedBox(height: 12),
            // Fee
            _SummaryRow(
              icon: Icons.payments,
              label: 'Consultation Fee',
              value: '৳${appointment.fee.toStringAsFixed(0)}',
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            // Appointment ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Appointment ID',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  appointment.appointmentId,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.buttonColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.buttonColor,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
