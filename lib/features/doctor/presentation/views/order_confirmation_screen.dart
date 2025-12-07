import 'package:flutter/material.dart';

import '../../../medicine/presentation/views/medicine_screen.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;
  final double total;
  const OrderConfirmationScreen(
      {super.key, required this.orderId, required this.total});

  @override
  Widget build(BuildContext context) {
    final eta = DateTime.now().add(const Duration(days: 3));
    return Scaffold(
      appBar: AppBar(title: const Text('Order Placed')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 84),
            const SizedBox(height: 12),
            const Text('Your order has been placed!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('Order ID: #$orderId'),
            const SizedBox(height: 4),
            Text('Total Paid: \$${total.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text('Estimated delivery: ${eta.day}/${eta.month}/${eta.year}'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Placeholder for tracking page
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tracking page coming soon')),
                );
              },
              child: const Text('Track Order'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) => const MedicineScreen(
                            isForm: false,
                          )),
                  (route) => false,
                );
              },
              child: const Text('Continue Shopping'),
            )
          ],
        ),
      ),
    );
  }
}
