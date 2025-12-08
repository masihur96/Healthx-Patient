import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';

import 'lab_booking_confirmation_screen.dart';

class BookingScreen extends StatefulWidget {
  final String testName;
  final double price;
  final String mode;

  const BookingScreen(
      {super.key,
      required this.testName,
      required this.price,
      required this.mode});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController addressCtrl = TextEditingController();
  DateTime? date;
  TimeOfDay? time;
  String? lab;
  String payment = 'Cash';

  @override
  void dispose() {
    addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHome = widget.mode == 'Home Collection';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(widget.testName,
                style: Theme.of(context).textTheme.titleMedium),
            Text('Mode: ${widget.mode}'),
            const SizedBox(height: 12),
            if (isHome)
              TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                    labelText: 'Address for home collection'),
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate:
                            DateTime.now().add(const Duration(days: 1)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) setState(() => date = picked);
                    },
                    child: Text(
                      date == null
                          ? 'Select Date'
                          : '${date!.day}/${date!.month}/${date!.year}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) setState(() => time = picked);
                    },
                    child: Text(
                      time == null ? 'Select Time' : time!.format(context),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (!isHome)
              DropdownButtonFormField<String>(
                value: lab,
                items: const [
                  DropdownMenuItem(
                      value: 'Downtown Lab', child: Text('Downtown Lab')),
                  DropdownMenuItem(
                      value: 'City Diagnostics',
                      child: Text('City Diagnostics')),
                ],
                onChanged: (v) => setState(() => lab = v),
                decoration: const InputDecoration(labelText: 'Preferred Lab'),
              ),
            const SizedBox(height: 12),
            Text('Payment'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                    label: const Text('Cash'),
                    selected: payment == 'Cash',
                    onSelected: (_) => setState(() => payment = 'Cash')),
                ChoiceChip(
                    label: const Text('Card'),
                    selected: payment == 'Card',
                    onSelected: (_) => setState(() => payment = 'Card')),
                ChoiceChip(
                    label: const Text('Online'),
                    selected: payment == 'Online',
                    onSelected: (_) => setState(() => payment = 'Online')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total'),
                Text('৳${widget.price.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final id =
                      'BK${DateTime.now().millisecondsSinceEpoch % 100000}';
                  final schedule =
                      '${date != null ? '${date!.day}/${date!.month}/${date!.year}' : ''} ${time != null ? time!.format(context) : ''}'
                          .trim();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => LabBookingConfirmationScreen(
                        bookingId: id,
                        testName: widget.testName,
                        schedule:
                            schedule.isEmpty ? 'To be scheduled' : schedule,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Confirm Booking',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
