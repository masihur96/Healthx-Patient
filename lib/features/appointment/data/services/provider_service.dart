import '../models/appointment_model.dart';
import '../models/provider_model.dart';

class ProviderService {
  // Mock data for demonstration
  static final List<Provider> _providers = [
    Provider(
      id: 'p1',
      name: 'Dr. Sarah Ahmed',
      specialty: 'Cardiologist',
      photo: 'assets/images/onboarding_preview1.png',
      experience: 12,
      rating: 4.8,
      reviewCount: 156,
      type: AppointmentType.doctor,
      location: 'Dhaka',
      fee: 30.0,
      hospital: 'City Heart Clinic',
      education: 'MBBS, MD (Cardiology)',
      languages: ['English', 'Bengali'],
      isOnlineAvailable: true,
      isInPersonAvailable: true,
    ),
    Provider(
      id: 'p2',
      name: 'Dr. Karim Hossain',
      specialty: 'Dermatologist',
      photo: 'assets/images/onboard.jpg',
      experience: 8,
      rating: 4.6,
      reviewCount: 98,
      type: AppointmentType.doctor,
      location: 'Chittagong',
      fee: 25.0,
      hospital: 'Skin Care Center',
      education: 'MBBS, FCPS (Dermatology)',
      languages: ['Bengali', 'English'],
      isOnlineAvailable: true,
      isInPersonAvailable: true,
    ),
    Provider(
      id: 'p3',
      name: 'Dr. Ayesha Rahman',
      specialty: 'Pediatrician',
      photo: 'assets/images/onboarding_preview1.png',
      experience: 10,
      rating: 4.9,
      reviewCount: 210,
      type: AppointmentType.doctor,
      location: 'Dhaka',
      fee: 28.0,
      hospital: 'Children\'s Hospital',
      education: 'MBBS, DCH',
      languages: ['Bengali', 'English', 'Hindi'],
      isOnlineAvailable: true,
      isInPersonAvailable: true,
    ),
    Provider(
      id: 'p4',
      name: 'Dr. Fatima Rahman',
      specialty: 'Neurologist',
      photo: 'assets/images/onboarding_preview1.png',
      experience: 15,
      rating: 4.7,
      reviewCount: 145,
      type: AppointmentType.specialist,
      location: 'Dhaka',
      fee: 40.0,
      hospital: 'Neuro Care Center',
      education: 'MBBS, MD (Neurology)',
      languages: ['English', 'Bengali'],
      isOnlineAvailable: true,
      isInPersonAvailable: false,
    ),
    Provider(
      id: 'p5',
      name: 'Dr. Mahmud Hasan',
      specialty: 'Orthopedic',
      photo: 'assets/images/onboard.jpg',
      experience: 18,
      rating: 4.8,
      reviewCount: 189,
      type: AppointmentType.specialist,
      location: 'Sylhet',
      fee: 35.0,
      hospital: 'Bone \u0026 Joint Clinic',
      education: 'MBBS, MS (Orthopedics)',
      languages: ['Bengali', 'English'],
      isOnlineAvailable: false,
      isInPersonAvailable: true,
    ),
    Provider(
      id: 'p6',
      name: 'City Lab Services',
      specialty: 'Blood Test',
      photo: 'assets/images/onboarding_preview1.png',
      experience: 20,
      rating: 4.5,
      reviewCount: 520,
      type: AppointmentType.lab,
      location: 'Dhaka',
      fee: 15.0,
      hospital: 'City Lab - Main Branch',
      education: null,
      languages: ['Bengali', 'English'],
      isOnlineAvailable: false,
      isInPersonAvailable: true,
    ),
    Provider(
      id: 'p7',
      name: 'Prime Diagnostics',
      specialty: 'X-Ray \u0026 Imaging',
      photo: 'assets/images/onboard.jpg',
      experience: 15,
      rating: 4.6,
      reviewCount: 340,
      type: AppointmentType.lab,
      location: 'Chittagong',
      fee: 20.0,
      hospital: 'Prime Diagnostics Center',
      education: null,
      languages: ['Bengali'],
      isOnlineAvailable: false,
      isInPersonAvailable: true,
    ),
    Provider(
      id: 'p8',
      name: 'Dr. Nasreen Akter',
      specialty: 'Gynecologist',
      photo: 'assets/images/onboarding_preview1.png',
      experience: 14,
      rating: 4.9,
      reviewCount: 267,
      type: AppointmentType.doctor,
      location: 'Dhaka',
      fee: 32.0,
      hospital: 'Women\'s Wellness Center',
      education: 'MBBS, FCPS (Gynecology)',
      languages: ['Bengali', 'English'],
      isOnlineAvailable: true,
      isInPersonAvailable: true,
    ),
  ];

  // Get all providers
  Future<List<Provider>> getProviders() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return List.from(_providers);
  }

  // Search providers by name or specialty
  Future<List<Provider>> searchProviders(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (query.isEmpty) {
      return List.from(_providers);
    }

    final lowerQuery = query.toLowerCase();
    return _providers.where((provider) {
      return provider.name.toLowerCase().contains(lowerQuery) ||
          provider.specialty.toLowerCase().contains(lowerQuery) ||
          (provider.hospital?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  // Filter providers
  Future<List<Provider>> filterProviders({
    AppointmentType? type,
    String? specialty,
    String? location,
    bool? onlineOnly,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    var filtered = List<Provider>.from(_providers);

    if (type != null) {
      filtered = filtered.where((p) => p.type == type).toList();
    }

    if (specialty != null && specialty.isNotEmpty) {
      filtered = filtered
          .where((p) => p.specialty.toLowerCase() == specialty.toLowerCase())
          .toList();
    }

    if (location != null && location.isNotEmpty) {
      filtered = filtered
          .where((p) => p.location.toLowerCase() == location.toLowerCase())
          .toList();
    }

    if (onlineOnly != null && onlineOnly) {
      filtered = filtered.where((p) => p.isOnlineAvailable).toList();
    }

    return filtered;
  }

  // Get provider by ID
  Future<Provider?> getProviderById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      return _providers.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get unique specialties
  List<String> getSpecialties() {
    return _providers
        .map((p) => p.specialty)
        .toSet()
        .toList()
      ..sort();
  }

  // Get unique locations
  List<String> getLocations() {
    return _providers
        .map((p) => p.location)
        .toSet()
        .toList()
      ..sort();
  }
}
