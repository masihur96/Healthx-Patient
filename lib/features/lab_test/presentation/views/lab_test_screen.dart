import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthx_patient/configs/custom_size.dart';
import 'package:healthx_patient/configs/custom_theme.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/features/home_tab/drawer_screen.dart';

import 'booking_screen.dart';
import 'digital_report_screen.dart';
import 'test_details_screen.dart';

class LabTestScreen extends StatefulWidget {
  final bool isForm;
  const LabTestScreen({super.key, required this.isForm});

  @override
  State<LabTestScreen> createState() => _LabTestScreenState();
}

class _LabTestScreenState extends State<LabTestScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recommended = [
      {
        'title': 'Full Body Checkup',
        'desc': '70+ parameters including CBC, LFT, KFT',
        'price': 2999.0,
        'report': '24-48 hrs'
      },
      {
        'title': 'Diabetes Profile',
        'desc': 'FBS, PPBS, HbA1c, Lipid Profile',
        'price': 1499.0,
        'report': '24 hrs'
      },
      {
        'title': 'Heart Health Package',
        'desc': 'Lipid, ECG, CRP, Homocysteine',
        'price': 1999.0,
        'report': '24-48 hrs'
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  widget.isForm
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios_outlined))
                      : SizedBox(),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Lab Tests & Diagnostics',
                    style: TextStyle(
                        fontSize: screenSize(context, .05),
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  widget.isForm
                      ? SizedBox()
                      : Builder(
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
              ),
              const SizedBox(height: 16),
              _buildSearchBar(context),
              const SizedBox(height: 16),
              _buildQuickActions(context),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Recommended Packages',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  // Could add a See all button later
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: recommended.length,
                  itemBuilder: (_, i) {
                    final p = recommended[i];

                    return Column(
                      children: [
                        _PackageCard(
                          title: p['title'] as String,
                          desc: p['desc'] as String,
                          price: p['price'] as double,
                          reportTime: p['report'] as String,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => TestDetailsScreen(
                                  testName: p['title'] as String,
                                  description: p['desc'] as String,
                                  parameters: const [],
                                  price: p['price'] as double,
                                  reportTime: p['report'] as String,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 12), // Vertical spacing
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchCtrl,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search test by name (e.g., CBC, Lipid Profile)',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (q) {
              if (q.trim().isEmpty) return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TestDetailsScreen(
                    testName: q.trim(),
                    description: 'Detailed diagnostics for $q',
                    parameters: const [],
                    price: 999,
                    reportTime: '24 hrs',
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          tooltip: 'Filter & Sort',
          onPressed: () async {
            await showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (_) => _FilterSheet(),
            );
          },
          icon: const Icon(Icons.tune),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            emoji: '🔬',
            title: 'Test',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TestDetailsScreen(
                    testName: 'CBC',
                    description: 'Complete Blood Count',
                    parameters: const ['RBC', 'WBC', 'Platelets'],
                    price: 500,
                    reportTime: '12 hrs',
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            emoji: '🏠',
            title: 'Sample',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BookingScreen(
                    testName: 'Home Collection',
                    price: 0,
                    mode: 'Home Collection',
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            emoji: '📁',
            title: 'Reports',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DigitalReportScreen()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String emoji;
  final String title;
  final VoidCallback onTap;
  const _QuickActionCard(
      {required this.emoji, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final String title;
  final String desc;
  final double price;
  final String reportTime;
  final VoidCallback onTap;
  const _PackageCard(
      {required this.title,
      required this.desc,
      required this.price,
      required this.reportTime,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: boxStyle(),
      // width: 260,
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(desc, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Text('Report: $reportTime',
                    style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('৳${price.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    const Icon(Icons.arrow_forward_rounded),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  String sort = 'Price';
  bool homeCollection = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sort by', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                  label: const Text('Price'),
                  selected: sort == 'Price',
                  onSelected: (_) => setState(() => sort = 'Price')),
              ChoiceChip(
                  label: const Text('Type'),
                  selected: sort == 'Type',
                  onSelected: (_) => setState(() => sort = 'Type')),
              ChoiceChip(
                  label: const Text('Availability'),
                  selected: sort == 'Availability',
                  onSelected: (_) => setState(() => sort = 'Availability')),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Switch(
                  value: homeCollection,
                  onChanged: (v) => setState(() => homeCollection = v)),
              const SizedBox(width: 8),
              const Text('Home sample collection'),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .pop({'sort': sort, 'home': homeCollection}),
              child: const Text(
                'Apply Filters',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
