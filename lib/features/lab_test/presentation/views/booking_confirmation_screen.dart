import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final Map<String, dynamic> payload;
  const BookingConfirmationScreen({super.key, required this.payload});

  @override
  State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  String _payment = 'Wallet';

  @override
  Widget build(BuildContext context) {
    final doctor = widget.payload['doctor'] as Map<String, dynamic>? ?? {};
    final DateTime date = widget.payload['date'] as DateTime? ?? DateTime.now();
    final String time = widget.payload['time']?.toString() ?? '';
    final String type = widget.payload['type']?.toString() ?? 'Online';
    final fee = doctor['fee'] ?? 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Booking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoTile(
              title: doctor['name'] ?? '',
              subtitle: doctor['specialty'] ?? '',
              trailing: '৳$fee',
            ),
            const SizedBox(height: 12),
            _InfoTile(
              title: 'Appointment',
              subtitle: '${date.day}/${date.month}/${date.year}  •  $time  •  $type',
            ),
            const SizedBox(height: 12),
            Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    RadioListTile<String>(
                      value: 'Wallet',
                      groupValue: _payment,
                      onChanged: (v) => setState(() => _payment = v ?? 'Wallet'),
                      title: const Text('Wallet'),
                    ),
                    RadioListTile<String>(
                      value: 'Card',
                      groupValue: _payment,
                      onChanged: (v) => setState(() => _payment = v ?? 'Card'),
                      title: const Text('Card'),
                    ),
                    RadioListTile<String>(
                      value: 'Cash',
                      groupValue: _payment,
                      onChanged: (v) => setState(() => _payment = v ?? 'Cash'),
                      title: const Text('Cash'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Your appointment is confirmed!'),
                      content: const Text('We have sent the details to your phone and email.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        )
                      ],
                    ),
                  );
                  if (!mounted) return;
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Confirm Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? trailing;
  const _InfoTile({required this.title, required this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: trailing != null ? Text(trailing!) : null,
      ),
    );
  }
}
