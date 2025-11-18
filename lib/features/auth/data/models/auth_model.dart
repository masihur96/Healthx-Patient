class AuthModel {
  final UserModel user;

  AuthModel({
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
    };
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String sex;
  final bool isActive;
  final String roleName;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.sex,
    required this.isActive,
    required this.roleName,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      sex: json['sex'],
      isActive: json['is_active'],
      roleName: json['role_name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'sex': sex,
      'is_active': isActive,
      'role_name': roleName,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
