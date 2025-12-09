import 'package:flutter/material.dart';

/// Enum for plan types
enum PlanType {
  basic,
  premium,
  family,
  corporate;

  String get displayName {
    switch (this) {
      case PlanType.basic:
        return 'Basic';
      case PlanType.premium:
        return 'Premium';
      case PlanType.family:
        return 'Family';
      case PlanType.corporate:
        return 'Corporate';
    }
  }

  Color get color {
    switch (this) {
      case PlanType.basic:
        return Colors.blue;
      case PlanType.premium:
        return Colors.purple;
      case PlanType.family:
        return Colors.green;
      case PlanType.corporate:
        return Colors.orange;
    }
  }
}

/// Enum for plan status
enum PlanStatus {
  active,
  expiringSoon,
  expired;

  String get displayName {
    switch (this) {
      case PlanStatus.active:
        return 'Active';
      case PlanStatus.expiringSoon:
        return 'Expiring Soon';
      case PlanStatus.expired:
        return 'Expired';
    }
  }

  Color get color {
    switch (this) {
      case PlanStatus.active:
        return Colors.green;
      case PlanStatus.expiringSoon:
        return Colors.orange;
      case PlanStatus.expired:
        return Colors.red;
    }
  }
}

/// Model for plan coverage details
class PlanCoverage {
  final int doctorVisits;
  final int labTests;
  final int teleconsultations;
  final double pharmacyDiscount; // Percentage

  const PlanCoverage({
    required this.doctorVisits,
    required this.labTests,
    required this.teleconsultations,
    required this.pharmacyDiscount,
  });

  List<String> get features => [
        '$doctorVisits Doctor Visits',
        '$labTests Lab Tests',
        '$teleconsultations Teleconsultations',
        '${pharmacyDiscount.toInt()}% Pharmacy Discount',
      ];
}

/// Model for benefit usage tracking
class PlanBenefit {
  final String type;
  final int total;
  final int used;

  const PlanBenefit({
    required this.type,
    required this.total,
    required this.used,
  });

  int get remaining => total - used;
  double get progressPercentage => used / total;
}

/// Main Health Plan model
class HealthPlan {
  final String id;
  final String name;
  final PlanType type;
  final String duration; // e.g., "1 Year", "6 Months"
  final double price;
  final String provider; // Hospital or insurance company
  final PlanCoverage coverage;
  final String bannerImage;
  final String description;
  final List<String> termsAndConditions;
  final PlanStatus? status; // null for available plans, set for subscribed plans
  final DateTime? subscriptionDate;
  final DateTime? expiryDate;
  final List<PlanBenefit>? benefits; // null for non-subscribed plans

  const HealthPlan({
    required this.id,
    required this.name,
    required this.type,
    required this.duration,
    required this.price,
    required this.provider,
    required this.coverage,
    required this.bannerImage,
    required this.description,
    required this.termsAndConditions,
    this.status,
    this.subscriptionDate,
    this.expiryDate,
    this.benefits,
  });

  bool get isSubscribed => status != null;

  String get coverageSummary {
    return '${coverage.doctorVisits} visits • ${coverage.labTests} tests • ${coverage.teleconsultations} teleconsults';
  }

  int? get daysUntilExpiry {
    if (expiryDate == null) return null;
    return expiryDate!.difference(DateTime.now()).inDays;
  }

  HealthPlan copyWith({
    String? id,
    String? name,
    PlanType? type,
    String? duration,
    double? price,
    String? provider,
    PlanCoverage? coverage,
    String? bannerImage,
    String? description,
    List<String>? termsAndConditions,
    PlanStatus? status,
    DateTime? subscriptionDate,
    DateTime? expiryDate,
    List<PlanBenefit>? benefits,
  }) {
    return HealthPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      provider: provider ?? this.provider,
      coverage: coverage ?? this.coverage,
      bannerImage: bannerImage ?? this.bannerImage,
      description: description ?? this.description,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      status: status ?? this.status,
      subscriptionDate: subscriptionDate ?? this.subscriptionDate,
      expiryDate: expiryDate ?? this.expiryDate,
      benefits: benefits ?? this.benefits,
    );
  }
}

/// Mock data for health plans
class MockHealthPlans {
  static const List<HealthPlan> availablePlans = [
    HealthPlan(
      id: '1',
      name: 'Basic Health Plan',
      type: PlanType.basic,
      duration: '1 Year',
      price: 5000,
      provider: 'City General Hospital',
      coverage: PlanCoverage(
        doctorVisits: 10,
        labTests: 5,
        teleconsultations: 15,
        pharmacyDiscount: 10,
      ),
      bannerImage: 'assets/images/health_plan_basic.jpg',
      description:
          'Perfect for individuals seeking essential healthcare coverage with basic benefits.',
      termsAndConditions: [
        'Valid for 12 months from activation date',
        'Coverage applies to in-network providers only',
        'Lab tests must be pre-approved',
        'Pharmacy discount valid at partner pharmacies',
        'Non-refundable after activation',
        'Can be renewed 30 days before expiry',
      ],
    ),
    HealthPlan(
      id: '2',
      name: 'Premium Care Plan',
      type: PlanType.premium,
      duration: '1 Year',
      price: 12000,
      provider: 'United Healthcare Group',
      coverage: PlanCoverage(
        doctorVisits: 25,
        labTests: 15,
        teleconsultations: 50,
        pharmacyDiscount: 25,
      ),
      bannerImage: 'assets/images/health_plan_premium.jpg',
      description:
          'Comprehensive coverage with enhanced benefits for those who want more.',
      termsAndConditions: [
        'Valid for 12 months from activation date',
        'Includes specialist consultations',
        'Priority booking available',
        'Extended pharmacy discount network',
        'Emergency care coverage included',
        'Transferable to immediate family with conditions',
      ],
    ),
    HealthPlan(
      id: '3',
      name: 'Family Wellness Package',
      type: PlanType.family,
      duration: '1 Year',
      price: 18000,
      provider: 'Family Care Medical Center',
      coverage: PlanCoverage(
        doctorVisits: 40,
        labTests: 20,
        teleconsultations: 100,
        pharmacyDiscount: 20,
      ),
      bannerImage: 'assets/images/health_plan_family.jpg',
      description:
          'Complete family coverage for up to 5 members with comprehensive benefits.',
      termsAndConditions: [
        'Covers up to 5 family members',
        'Valid for 12 months from activation date',
        'All benefits shared among family members',
        'Pediatric care included',
        'Maternity coverage available',
        'Annual health checkups for all members',
      ],
    ),
    HealthPlan(
      id: '4',
      name: 'Corporate Health Shield',
      type: PlanType.corporate,
      duration: '1 Year',
      price: 25000,
      provider: 'Corporate Wellness Solutions',
      coverage: PlanCoverage(
        doctorVisits: 50,
        labTests: 30,
        teleconsultations: 150,
        pharmacyDiscount: 30,
      ),
      bannerImage: 'assets/images/health_plan_corporate.jpg',
      description:
          'Premium corporate plan with unlimited teleconsultations and priority care.',
      termsAndConditions: [
        'Designed for corporate employees',
        'Executive health checkups included',
        'Mental health support available',
        'Dental and vision care coverage',
        'International coverage for emergencies',
        'Dedicated account manager',
      ],
    ),
    HealthPlan(
      id: '5',
      name: 'Essential Care Plan',
      type: PlanType.basic,
      duration: '6 Months',
      price: 3000,
      provider: 'Community Health Network',
      coverage: PlanCoverage(
        doctorVisits: 6,
        labTests: 3,
        teleconsultations: 10,
        pharmacyDiscount: 8,
      ),
      bannerImage: 'assets/images/health_plan_basic.jpg',
      description:
          'Short-term coverage ideal for budget-conscious individuals.',
      termsAndConditions: [
        'Valid for 6 months from activation date',
        'Basic coverage only',
        'Limited to general physicians',
        'No emergency coverage',
        'Renewable after expiry',
      ],
    ),
    HealthPlan(
      id: '6',
      name: 'Premium Plus Plan',
      type: PlanType.premium,
      duration: '2 Years',
      price: 22000,
      provider: 'Elite Medical Services',
      coverage: PlanCoverage(
        doctorVisits: 60,
        labTests: 35,
        teleconsultations: 120,
        pharmacyDiscount: 28,
      ),
      bannerImage: 'assets/images/health_plan_premium.jpg',
      description:
          'Extended premium coverage with better value for long-term health planning.',
      termsAndConditions: [
        'Valid for 24 months from activation date',
        'Specialist access without referrals',
        'Preventive care included',
        'Annual wellness programs',
        'International treatment support',
      ],
    ),
    HealthPlan(
      id: '7',
      name: 'Senior Care Package',
      type: PlanType.family,
      duration: '1 Year',
      price: 15000,
      provider: 'Senior Wellness Clinic',
      coverage: PlanCoverage(
        doctorVisits: 30,
        labTests: 25,
        teleconsultations: 80,
        pharmacyDiscount: 22,
      ),
      bannerImage: 'assets/images/health_plan_family.jpg',
      description:
          'Specialized care for seniors aged 60+ with enhanced medical support.',
      termsAndConditions: [
        'For individuals aged 60 and above',
        'Geriatric specialist consultations included',
        'Chronic disease management',
        'Home healthcare eligible',
        'No pre-existing condition exclusions',
      ],
    ),
    HealthPlan(
      id: '8',
      name: 'Executive Elite Plan',
      type: PlanType.corporate,
      duration: '1 Year',
      price: 35000,
      provider: 'Premier Health Partners',
      coverage: PlanCoverage(
        doctorVisits: 100,
        labTests: 50,
        teleconsultations: 200,
        pharmacyDiscount: 35,
      ),
      bannerImage: 'assets/images/health_plan_corporate.jpg',
      description:
          'Ultimate healthcare solution for executives with VIP treatment.',
      termsAndConditions: [
        'VIP treatment at all partner facilities',
        'Global coverage with air ambulance',
        'Personal health concierge',
        'Advanced diagnostics included',
        'Second opinion consultations',
        'Wellness retreat programs',
      ],
    ),
  ];

  // Mock subscribed/active plans
  static List<HealthPlan> getActivePlans() {
    final now = DateTime.now();
    return [
      availablePlans[1].copyWith(
        status: PlanStatus.active,
        subscriptionDate: DateTime(now.year, now.month - 2, now.day),
        expiryDate: DateTime(now.year + 1, now.month - 2, now.day),
        benefits: const [
          PlanBenefit(type: 'Doctor Visits', total: 25, used: 6),
          PlanBenefit(type: 'Lab Tests', total: 15, used: 3),
          PlanBenefit(type: 'Teleconsultations', total: 50, used: 12),
        ],
      ),
    ];
  }

  static List<HealthPlan> getExpiredPlans() {
    final now = DateTime.now();
    return [
      availablePlans[0].copyWith(
        status: PlanStatus.expired,
        subscriptionDate: DateTime(now.year - 1, now.month - 3, now.day),
        expiryDate: DateTime(now.year, now.month - 3, now.day),
        benefits: const [
          PlanBenefit(type: 'Doctor Visits', total: 10, used: 10),
          PlanBenefit(type: 'Lab Tests', total: 5, used: 5),
          PlanBenefit(type: 'Teleconsultations', total: 15, used: 15),
        ],
      ),
    ];
  }
}
