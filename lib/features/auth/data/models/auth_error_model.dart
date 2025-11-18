class AuthErrorModel {
  final int status;
  final String name;
  final String message;
  final Map<String, dynamic> details;

  AuthErrorModel({
    required this.status,
    required this.name,
    required this.message,
    required this.details,
  });

  factory AuthErrorModel.fromJson(Map<String, dynamic> json) {
    return AuthErrorModel(
      status: json['status'] ?? 0,
      name: json['name'] ?? '',
      message: json['message'] ?? 'An error occurred',
      details: json['details'] ?? {},
    );
  }
} 