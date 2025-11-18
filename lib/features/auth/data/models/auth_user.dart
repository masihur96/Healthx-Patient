class AuthUser {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String avatarUrl;
  final bool isEmailVerified;

  AuthUser({
    this.id = 'dummy_id',
    this.name = 'John Doe',
    this.email = 'johndoe@example.com',
    this.phoneNumber = '+880123456789',
    this.avatarUrl = 'https://i.pravatar.cc/150?img=3',
    this.isEmailVerified = false,
  });

  factory AuthUser.fromMap(Map<String, dynamic> data) {
    return AuthUser(
      id: data['id'] ?? 'dummy_id',
      name: data['name'] ?? 'John Doe',
      email: data['email'] ?? 'johndoe@example.com',
      phoneNumber: data['phoneNumber'] ?? '+880123456789',
      avatarUrl: data['avatarUrl'] ?? 'https://i.pravatar.cc/150?img=3',
      isEmailVerified: data['isEmailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'isEmailVerified': isEmailVerified,
    };
  }
}
