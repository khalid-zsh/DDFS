class User {
  final String id;
  final String role;
  final String email;

  User({required this.id, required this.role, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'email': email,
    };
  }
}