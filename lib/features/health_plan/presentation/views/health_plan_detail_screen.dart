import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/features/health_plan/data/models/health_plan_model.dart';

import 'subscription_screen.dart';

class HealthPlanDetailScreen extends StatefulWidget {
  final HealthPlan plan;

  const HealthPlanDetailScreen({super.key, required this.plan});

  @override
  State<HealthPlanDetailScreen> createState() => _HealthPlanDetailScreenState();
}

class _HealthPlanDetailScreenState extends State<HealthPlanDetailScreen> {
  bool _termsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: CustomScrollView(
        slivers: [
          // App Bar with Banner
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.buttonColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined,
                  color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.plan.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3.0,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient background as placeholder for banner image
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          widget.plan.type.color,
                          widget.plan.type.color.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  // Overlay pattern
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.1,
                      child: Image.asset(
                        'assets/images/onboard.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plan Info Card
                  _buildPlanInfoCard(),
                  const SizedBox(height: 16),

                  // Description
                  _buildSectionTitle('About this Plan'),
                  const SizedBox(height: 8),
                  _buildCard(
                    child: Text(
                      widget.plan.description,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Coverage Details
                  _buildSectionTitle('Coverage Details'),
                  const SizedBox(height: 8),
                  _buildCoverageCard(),
                  const SizedBox(height: 16),

                  // Provider Information
                  _buildSectionTitle('Provider Information'),
                  const SizedBox(height: 8),
                  _buildProviderCard(),
                  const SizedBox(height: 16),

                  // Terms & Conditions
                  _buildSectionTitle('Terms & Conditions'),
                  const SizedBox(height: 8),
                  _buildTermsCard(),

                  const SizedBox(height: 100), // Space for fixed button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildPlanInfoCard() {
    return _buildCard(
      child: Row(
        children: [
          Expanded(
            child: _buildInfoItem(
              icon: Icons.access_time,
              label: 'Duration',
              value: widget.plan.duration,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: _buildInfoItem(
              icon: Icons.payments,
              label: 'Price',
              value: '৳${widget.plan.price.toStringAsFixed(0)}',
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: _buildInfoItem(
              icon: Icons.category,
              label: 'Type',
              value: widget.plan.type.displayName,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColors.buttonColor, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCoverageCard() {
    final features = [
      {
        'icon': Icons.local_hospital,
        'title': 'Doctor Visits',
        'value': '${widget.plan.coverage.doctorVisits} visits',
      },
      {
        'icon': Icons.science,
        'title': 'Lab Tests',
        'value': '${widget.plan.coverage.labTests} tests',
      },
      {
        'icon': Icons.video_call,
        'title': 'Teleconsultations',
        'value': '${widget.plan.coverage.teleconsultations} sessions',
      },
      {
        'icon': Icons.local_pharmacy,
        'title': 'Pharmacy Discount',
        'value': '${widget.plan.coverage.pharmacyDiscount.toInt()}% off',
      },
    ];

    return _buildCard(
      child: Column(
        children: features.map((feature) {
          final isLast = feature == features.last;
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    feature['icon'] as IconData,
                    color: AppColors.buttonColor,
                    size: 24,
                  ),
                ),
                title: Text(
                  feature['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                trailing: Text(
                  feature['value'] as String,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (!isLast) Divider(color: Colors.grey.shade200),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProviderCard() {
    return _buildCard(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.buttonColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.business,
            color: AppColors.buttonColor,
            size: 28,
          ),
        ),
        title: Text(
          widget.plan.provider,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Authorized Health Provider',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
          ),
        ),
        trailing: Icon(
          Icons.verified,
          color: Colors.green.shade600,
        ),
      ),
    );
  }

  Widget _buildTermsCard() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() => _termsExpanded = !_termsExpanded);
            },
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                Icon(
                  _termsExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.buttonColor,
                ),
              ],
            ),
          ),
          if (_termsExpanded) ...[
            const SizedBox(height: 12),
            ...widget.plan.termsAndConditions.map((term) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        term,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    '৳${widget.plan.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SubscriptionScreen(plan: widget.plan),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Subscribe Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
