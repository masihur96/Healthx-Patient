import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';

import 'cart_scope.dart';
import 'order_confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressCtrl = TextEditingController(text: '221B Baker Street, London');
  String _payment = 'COD';
  bool _loading = false;

  @override
  void dispose() {
    _addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
              onPressed: () {}, icon: Icon(Icons.arrow_back_ios_outlined)),
          title: const Text('Checkout')),
      body: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Delivery Address',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _addressCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Payment Method',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                      label: const Text('COD'),
                      selected: _payment == 'COD',
                      onSelected: (_) => setState(() => _payment = 'COD')),
                  ChoiceChip(
                      label: const Text('Card'),
                      selected: _payment == 'Card',
                      onSelected: (_) => setState(() => _payment = 'Card')),
                  ChoiceChip(
                      label: const Text('Mobile Wallet'),
                      selected: _payment == 'Mobile Wallet',
                      onSelected: (_) =>
                          setState(() => _payment = 'Mobile Wallet')),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Order Summary',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ...cart.items.map((i) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(i.medicine.name,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text('Qty: ${i.quantity}'),
                    trailing: Text(
                        '৳${(i.medicine.price * i.quantity).toStringAsFixed(2)}'),
                  )),
              const Divider(height: 24),
              Row(
                children: [
                  const Text('Total',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Text('৳${cart.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loading
                    ? null
                    : () async {
                        setState(() => _loading = true);
                        await Future.delayed(const Duration(seconds: 2));
                        if (!mounted) return;
                        final orderId =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        final total = cart.totalPrice;
                        cart.clear();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => OrderConfirmationScreen(
                                orderId: orderId, total: total),
                          ),
                        );
                      },
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : Text(
                        'Confirm Order',
                        style: TextStyle(color: Colors.white),
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}
