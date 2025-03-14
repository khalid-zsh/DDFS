class LogModel {
  final String logId;
  final String action; // e.g., "Device Connected", "Extraction Started"
  final DateTime timestamp;

  LogModel({
    required this.logId,
    required this.action,
    required this.timestamp,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      logId: json['logId'],
      action: json['action'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logId': logId,
      'action': action,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
