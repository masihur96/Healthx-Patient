class UserProfileResponse {
  final UserProfile data;
  final ProfileMeta meta;

  UserProfileResponse({
    required this.data,
    required this.meta,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        data: UserProfile.fromJson(json['data'] ?? {}),
        meta: ProfileMeta.fromJson(json['meta'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
        'meta': meta.toJson(),
      };
}

class UserProfile {
  final int? id;
  final String? documentId;
  final String? fullName;
  final String? phoneNumber;
  final String? email;
  final String? avatar;
  final String? gender;
  final String? dateOfBirth;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final String? division;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? publishedAt;
  final String? locale;
  final String? role;

  UserProfile({
    this.id,
    this.documentId,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.avatar,
    this.gender,
    this.dateOfBirth,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.division,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.locale,
    this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'] as int?,
        documentId: json['documentId'] as String?,
        fullName: json['fullName'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        email: json['email'] as String?,
        avatar: json['avatar'] as String?,
        gender: json['gender'] as String?,
        dateOfBirth: json['dateOfBirth'] as String?,
        addressLine1: json['addressLine1'] as String?,
        addressLine2: json['addressLine2'] as String?,
        city: json['city'] as String?,
        state: json['state'] as String?,
        postalCode: json['postalCode'] as String?,
        country: json['country'] as String?,
        division: json['division'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'])
            : null,
        publishedAt: json['publishedAt'] as String?,
        locale: json['locale'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'documentId': documentId,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'email': email,
        'avatar': avatar,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'country': country,
        'division': division,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'publishedAt': publishedAt,
        'locale': locale,
        'role': role,
      };
}

class ProfileMeta {
  ProfileMeta();

  factory ProfileMeta.fromJson(Map<String, dynamic> json) => ProfileMeta();

  Map<String, dynamic> toJson() => {};
}
