class AuthTokenModel {
  final String refresh;
  final String access;
  final List<String> roles;

  AuthTokenModel({
    required this.refresh,
    required this.access,
    required this.roles,
  });

  /// Factory constructor to create an instance from JSON
  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      refresh: json['refresh'] ?? '',
      access: json['access'] ?? '',
      roles: List<String>.from(json['role'] ?? []),
    );
  }

  /// Convert model instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'refresh': refresh,
      'access': access,
      'role': roles,
    };
  }
}
