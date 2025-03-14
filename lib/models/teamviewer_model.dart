class TeamViewerModel {
  final String sessionId;
  final String password;
  final DateTime createdAt;

  TeamViewerModel({
    required this.sessionId,
    required this.password,
    required this.createdAt,
  });

  factory TeamViewerModel.fromJson(Map<String, dynamic> json) {
    return TeamViewerModel(
      sessionId: json['sessionId'],
      password: json['password'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
