import 'package:flutter/material.dart';

class LabBookingConfirmationScreen extends StatelessWidget {
  final String bookingId;
  final String testName;
  final String schedule;
  const LabBookingConfirmationScreen({super.key, required this.bookingId, required this.testName, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Confirmed')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Icon(Icons.verified_rounded, size: 80, color: Colors.green),
            const SizedBox(height: 16),
            const Text('Your test has been booked successfully!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Material(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              child: ListTile(
                title: Text(testName, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('Booking ID: $bookingId\nSchedule: $schedule'),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('View Booking Details'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                child: const Text('Go to Dashboard'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
