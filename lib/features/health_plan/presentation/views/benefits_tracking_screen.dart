import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/features/health_plan/data/models/health_plan_model.dart';

import 'health_plan_screen.dart';
import 'subscription_screen.dart';

class BenefitsTrackingScreen extends StatelessWidget {
  final HealthPlan plan;

  const BenefitsTrackingScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text('Benefits Tracking'),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_outlined)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Plan Header Card
          _buildPlanHeaderCard(),
          const SizedBox(height: 20),

          // Benefits Usage
          _buildSectionTitle('Benefits Usage'),
          const SizedBox(height: 12),
          if (plan.benefits != null) ...[
            ...plan.benefits!.map((benefit) => _buildBenefitCard(benefit)),
          ],
          const SizedBox(height: 20),

          // Plan Validity Summary
          _buildSectionTitle('Plan Validity'),
          const SizedBox(height: 12),
          _buildValidityCard(context),
          const SizedBox(height: 20),

          // Action Buttons
          _buildActionButtons(context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPlanHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            plan.type.color,
            plan.type.color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: plan.type.color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.health_and_safety,
                  color: plan.type.color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      plan.provider,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.verified,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  plan.status!.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitCard(PlanBenefit benefit) {
    final percentage = benefit.progressPercentage;
    final isHighUsage = percentage > 0.75;
    final isMediumUsage = percentage > 0.5 && percentage <= 0.75;

    Color progressColor;
    if (isHighUsage) {
      progressColor = Colors.orange;
    } else if (isMediumUsage) {
      progressColor = Colors.blue;
    } else {
      progressColor = Colors.green;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: progressColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIconForBenefit(benefit.type),
                      color: progressColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    benefit.type,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: progressColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(percentage * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: progressColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Used',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      '${benefit.used}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remaining',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      '${benefit.remaining}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: progressColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      '${benefit.total}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidityCard(BuildContext context) {
    final daysLeft = plan.daysUntilExpiry ?? 0;
    final isExpiringSoon = daysLeft <= 30;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isExpiringSoon ? Colors.orange.shade50 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              isExpiringSoon ? Colors.orange.shade200 : Colors.green.shade200,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isExpiringSoon ? Icons.warning_amber_rounded : Icons.check_circle,
            size: 48,
            color:
                isExpiringSoon ? Colors.orange.shade700 : Colors.green.shade700,
          ),
          const SizedBox(height: 12),
          Text(
            isExpiringSoon ? 'Plan Expiring Soon!' : 'Plan Active',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isExpiringSoon
                  ? Colors.orange.shade900
                  : Colors.green.shade900,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade800,
              ),
              children: [
                const TextSpan(text: 'Plan valid until '),
                TextSpan(
                  text: _formatDate(plan.expiryDate!),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isExpiringSoon
                        ? Colors.orange.shade900
                        : Colors.green.shade900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$daysLeft days remaining',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isExpiringSoon
                  ? Colors.orange.shade700
                  : Colors.green.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // Navigate to higher-tier plans filtered view
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const HealthPlanScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.upgrade,
              color: Colors.white,
            ),
            label: const Text('Upgrade Plan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: plan.type.color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SubscriptionScreen(plan: plan),
                ),
              );
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            label: const Text(
              'Renew Now',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.buttonColor,
              side: const BorderSide(color: AppColors.buttonColor, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
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

  IconData _getIconForBenefit(String type) {
    if (type.toLowerCase().contains('doctor')) {
      return Icons.local_hospital;
    } else if (type.toLowerCase().contains('lab')) {
      return Icons.science;
    } else if (type.toLowerCase().contains('tele')) {
      return Icons.video_call;
    } else {
      return Icons.check_circle;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
