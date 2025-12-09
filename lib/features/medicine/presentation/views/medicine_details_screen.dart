import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';

import '../../../doctor/presentation/views/cart_scope.dart';
import '../../../doctor/presentation/views/cart_screen.dart';
import 'medicine_models.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final Medicine medicine;
  final CartState cart;
  const MedicineDetailsScreen(
      {super.key, required this.medicine, required this.cart});

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Medicine Details'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_outlined)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset("assets/images/medicine.jpg",
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 12),
            Text(widget.medicine.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(widget.medicine.brand,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color)),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(label: Text(widget.medicine.dosage)),
                const SizedBox(width: 8),
                Chip(label: Text(widget.medicine.packaging)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('৳${widget.medicine.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                Icon(
                    widget.medicine.inStock ? Icons.check_circle : Icons.cancel,
                    color: widget.medicine.inStock ? Colors.green : Colors.red),
                const SizedBox(width: 4),
                Text(widget.medicine.inStock ? 'In stock' : 'Out of stock'),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Description',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(widget.medicine.description),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            setState(() => qty = qty > 1 ? qty - 1 : 1),
                        icon: const Icon(Icons.remove),
                      ),
                      Text('$qty',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      IconButton(
                        onPressed: () => setState(() => qty += 1),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: widget.medicine.inStock
                      ? () {
                          widget.cart.add(widget.medicine, qty: qty);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${widget.medicine.name} added to cart'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      : null,
                  icon:
                      const Icon(Icons.add_shopping_cart, color: Colors.white),
                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CartScope(
                      notifier: widget.cart,
                      child: const CartScreen(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_checkout),
              label: const Text('Go to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
