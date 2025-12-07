import 'package:flutter/material.dart';
import '../../data/models/appointment_model.dart';

class StatusBadgeWidget extends StatelessWidget {
  final AppointmentStatus status;
  final double fontSize;

  const StatusBadgeWidget({
    super.key,
    required this.status,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: _getTextColor(),
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (status) {
      case AppointmentStatus.confirmed:
        return Colors.green.shade50;
      case AppointmentStatus.pending:
        return Colors.orange.shade50;
      case AppointmentStatus.completed:
        return Colors.blue.shade50;
      case AppointmentStatus.cancelled:
        return Colors.red.shade50;
    }
  }

  Color _getTextColor() {
    switch (status) {
      case AppointmentStatus.confirmed:
        return Colors.green.shade700;
      case AppointmentStatus.pending:
        return Colors.orange.shade700;
      case AppointmentStatus.completed:
        return Colors.blue.shade700;
      case AppointmentStatus.cancelled:
        return Colors.red.shade700;
    }
  }
}
