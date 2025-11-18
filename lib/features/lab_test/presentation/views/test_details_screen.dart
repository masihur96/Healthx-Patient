import 'package:flutter/material.dart';
import 'booking_screen.dart';

class TestDetailsScreen extends StatefulWidget {
  final String testName;
  final String description;
  final List<String> parameters;
  final double price;
  final String reportTime;

  const TestDetailsScreen({super.key, required this.testName, required this.description, required this.parameters, required this.price, required this.reportTime});

  @override
  State<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  String mode = 'At Lab';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.testName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            if (widget.parameters.isNotEmpty)
              Text('Includes', style: Theme.of(context).textTheme.titleMedium),
            if (widget.parameters.isNotEmpty)
              const SizedBox(height: 8),
            if (widget.parameters.isNotEmpty)
              ...widget.parameters.map((p) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, size: 18, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(child: Text(p)),
                      ],
                    ),
                  )),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('৳${widget.price.toStringAsFixed(0)}', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(width: 12),
                Text('Report: ${widget.reportTime}', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('At Lab'),
                  selected: mode == 'At Lab',
                  onSelected: (_) => setState(() => mode = 'At Lab'),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Home Collection'),
                  selected: mode == 'Home Collection',
                  onSelected: (_) => setState(() => mode = 'Home Collection'),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BookingScreen(
                        testName: widget.testName,
                        price: widget.price,
                        mode: mode,
                      ),
                    ),
                  );
                },
                child: const Text('Book Now'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
