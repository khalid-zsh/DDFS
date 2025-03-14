class UserModel {
  final String userId;
  final String name;
  final String email;
  final String role; // Admin, Support, End-User
  final bool isAuthenticated;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    required this.isAuthenticated,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      isAuthenticated: json['isAuthenticated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
      'isAuthenticated': isAuthenticated,
    };
  }
}
