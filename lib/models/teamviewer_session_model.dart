class TeamViewerSession {
  final String sessionId;
  final String password;

  TeamViewerSession({required this.sessionId, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'password': password,
    };
  }
}