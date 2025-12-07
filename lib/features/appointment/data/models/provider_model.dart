import 'appointment_model.dart';

class Provider {
  final String id;
  final String name;
  final String specialty;
  final String photo;
  final int experience;
  final double rating;
  final int reviewCount;
  final AppointmentType type;
  final String location;
  final double fee;
  final bool isOnlineAvailable;
  final bool isInPersonAvailable;
  final String? hospital;
  final String? education;
  final List<String>? languages;

  Provider({
    required this.id,
    required this.name,
    required this.specialty,
    required this.photo,
    required this.experience,
    required this.rating,
    required this.reviewCount,
    required this.type,
    required this.location,
    required this.fee,
    this.isOnlineAvailable = true,
    this.isInPersonAvailable = true,
    this.hospital,
    this.education,
    this.languages,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
      photo: json['photo'] ?? '',
      experience: json['experience'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      type: AppointmentType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AppointmentType.doctor,
      ),
      location: json['location'] ?? '',
      fee: (json['fee'] ?? 0).toDouble(),
      isOnlineAvailable: json['is_online_available'] ?? true,
      isInPersonAvailable: json['is_in_person_available'] ?? true,
      hospital: json['hospital'],
      education: json['education'],
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'photo': photo,
      'experience': experience,
      'rating': rating,
      'review_count': reviewCount,
      'type': type.name,
      'location': location,
      'fee': fee,
      'is_online_available': isOnlineAvailable,
      'is_in_person_available': isInPersonAvailable,
      'hospital': hospital,
      'education': education,
      'languages': languages,
    };
  }

  Provider copyWith({
    String? id,
    String? name,
    String? specialty,
    String? photo,
    int? experience,
    double? rating,
    int? reviewCount,
    AppointmentType? type,
    String? location,
    double? fee,
    bool? isOnlineAvailable,
    bool? isInPersonAvailable,
    String? hospital,
    String? education,
    List<String>? languages,
  }) {
    return Provider(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      photo: photo ?? this.photo,
      experience: experience ?? this.experience,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      type: type ?? this.type,
      location: location ?? this.location,
      fee: fee ?? this.fee,
      isOnlineAvailable: isOnlineAvailable ?? this.isOnlineAvailable,
      isInPersonAvailable: isInPersonAvailable ?? this.isInPersonAvailable,
      hospital: hospital ?? this.hospital,
      education: education ?? this.education,
      languages: languages ?? this.languages,
    );
  }
}
