import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthx_patient/configs/custom_size.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/features/home_tab/drawer_screen.dart';

import '../../../doctor/presentation/views/cart_scope.dart';
import '../../../doctor/presentation/views/cart_screen.dart';
import 'medicine_details_screen.dart';
import 'medicine_models.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({super.key});

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  final CartState _cart = CartState();
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      setState(() => _query = _searchCtrl.text.trim());
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Medicine> _filtered() {
    final q = _query.toLowerCase();
    return MockData.medicines.where((m) {
      final matchesQuery = q.isEmpty ||
          m.name.toLowerCase().contains(q) ||
          m.brand.toLowerCase().contains(q);
      final matchesCat =
          _selectedCategory == null || m.category == _selectedCategory;
      return matchesQuery && matchesCat;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CartScope(
      notifier: _cart,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Row(
              children: [
                Text(
                  'Order Medicines',
                  style: TextStyle(
                      fontSize: screenSize(context, .05),
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.shopping_cart_outlined, size: 26),
                        Positioned(
                          right: -6,
                          top: -6,
                          child: AnimatedBuilder(
                            animation: _cart,
                            builder: (context, _) {
                              final count = _cart.itemCount;
                              if (count == 0) return const SizedBox.shrink();
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '$count',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Builder(
                  builder: (ctx) => GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Icon(
                        Icons.menu,
                        size: screenSize(context, .08),
                      ),
                    ),
                    onTap: () {
                      z.toggle?.call();
                      HapticFeedback.selectionClick();
                    },
                  ),
                ),
                const SizedBox(width: 8),
              ],
            )),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Search by medicine name or brand',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 46,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return ActionChip(
                        avatar: const Icon(Icons.category, size: 18),
                        label: const Text('Browse Categories'),
                        onPressed: () async {
                          final cat = await showModalBottomSheet<String>(
                            context: context,
                            showDragHandle: true,
                            builder: (ctx) =>
                                _CategorySheet(selected: _selectedCategory),
                          );
                          if (cat != null) {
                            setState(() =>
                                _selectedCategory = cat == 'All' ? null : cat);
                          }
                        },
                      );
                    }
                    final cats = ['All', ...MockData.categories];
                    final cat = cats[index - 1];
                    final selected = (_selectedCategory ?? 'All') == cat;
                    return ChoiceChip(
                      label: Text(cat),
                      selected: selected,
                      onSelected: (_) {
                        setState(() =>
                            _selectedCategory = cat == 'All' ? null : cat);
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: 1 + (1 + MockData.categories.length),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final crossAxisCount = c.maxWidth > 800
                          ? 4
                          : c.maxWidth > 600
                              ? 3
                              : 2;
                      final meds = _filtered();
                      if (meds.isEmpty) {
                        return const Center(child: Text('No medicines found'));
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.62,
                        ),
                        itemCount: meds.length,
                        itemBuilder: (context, index) {
                          final m = meds[index];
                          return _MedicineCard(
                            medicine: m,
                            onOpen: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MedicineDetailsScreen(medicine: m),
                                ),
                              );
                            },
                            onAdd: () {
                              _cart.add(m);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${m.name} added to cart'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final VoidCallback onOpen;
  final VoidCallback onAdd;
  const _MedicineCard(
      {required this.medicine, required this.onOpen, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    print(medicine.imageUrl);
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    medicine.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                medicine.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                medicine.brand,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '৳${medicine.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: medicine.inStock ? onAdd : null,
                    icon: Icon(
                      Icons.add_shopping_cart,
                      size: 18,
                      color: AppColors.yellow,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategorySheet extends StatelessWidget {
  final String? selected;
  const _CategorySheet({this.selected});

  @override
  Widget build(BuildContext context) {
    final cats = ['All', ...MockData.categories];
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: cats.length,
      itemBuilder: (context, index) {
        final c = cats[index];
        final isSel = (selected ?? 'All') == c;
        return ListTile(
          title: Text(c),
          trailing: isSel ? const Icon(Icons.check, color: Colors.blue) : null,
          onTap: () => Navigator.of(context).pop(c),
        );
      },
    );
  }
}
