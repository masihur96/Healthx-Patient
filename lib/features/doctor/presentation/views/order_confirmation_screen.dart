import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';

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
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
              onPressed: () {}, icon: Icon(Icons.arrow_back_ios_outlined)),
          title: const Text('Order Placed')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
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
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (_) => const MedicineScreen(
                              isForm: false,
                            )),
                    (route) => false,
                  );
                },
                child: Text(
                  'Continue Shopping',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
