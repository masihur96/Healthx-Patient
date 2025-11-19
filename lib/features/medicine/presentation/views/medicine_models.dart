import 'package:flutter/material.dart';

class Medicine {
  final String id;
  final String name;
  final String brand;
  final String dosage;
  final String packaging;
  final String description;
  final double price;
  final bool inStock;
  final String imageUrl;
  final String category;

  const Medicine({
    required this.id,
    required this.name,
    required this.brand,
    required this.dosage,
    required this.packaging,
    required this.description,
    required this.price,
    required this.inStock,
    required this.imageUrl,
    required this.category,
  });
}

class CartItem {
  final Medicine medicine;
  int quantity;
  CartItem({required this.medicine, this.quantity = 1});
}

class CartState extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();
  int get itemCount => _items.values.fold(0, (sum, i) => sum + i.quantity);
  double get totalPrice =>
      _items.values.fold(0.0, (sum, i) => sum + i.quantity * i.medicine.price);

  void add(Medicine m, {int qty = 1}) {
    final existing = _items[m.id];
    if (existing != null) {
      existing.quantity += qty;
    } else {
      _items[m.id] = CartItem(medicine: m, quantity: qty);
    }
    notifyListeners();
  }

  void remove(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void setQuantity(String id, int qty) {
    if (_items.containsKey(id)) {
      if (qty <= 0) {
        _items.remove(id);
      } else {
        _items[id]!.quantity = qty;
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

class MockData {
  static final medicines = <Medicine>[
    Medicine(
      id: 'med1',
      name: 'Paracetamol 500mg',
      brand: 'Acme Pharma',
      dosage: '500mg',
      packaging: 'Strip of 10 tablets',
      description:
          'Used for pain relief and fever reduction. May cause nausea in rare cases. Manufacturer: Acme Pharma.',
      price: 2.49,
      inStock: true,
      imageUrl: 'assets/icon/icon.jpeg',
      category: 'Pain Relief',
    ),
    Medicine(
      id: 'med2',
      name: 'Metformin 850mg',
      brand: 'Beta Labs',
      dosage: '850mg',
      packaging: 'Bottle of 60 tablets',
      description:
          'Used to control high blood sugar in type 2 diabetes. May cause stomach upset. Manufacturer: Beta Labs.',
      price: 6.99,
      inStock: true,
      imageUrl: 'assets/icon/icon.jpeg',
      category: 'Diabetes',
    ),
    Medicine(
      id: 'med3',
      name: 'Atenolol 50mg',
      brand: 'CardioCare',
      dosage: '50mg',
      packaging: 'Strip of 14 tablets',
      description:
          'Beta-blocker used for high blood pressure. May cause dizziness. Manufacturer: CardioCare.',
      price: 4.99,
      inStock: false,
      imageUrl: 'assets/icon/icon.jpeg',
      category: 'Cardiac',
    ),
  ];

  static final categories = <String>[
    'Pain Relief',
    'Diabetes',
    'Cardiac',
    'Allergy',
    'Vitamins',
  ];
}
