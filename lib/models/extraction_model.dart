class ExtractionModel {
  final String deviceId;
  final String status;
  final DateTime timestamp;

  ExtractionModel({
    required this.deviceId,
    required this.status,
    required this.timestamp,
  });

  factory ExtractionModel.fromJson(Map<String, dynamic> json) {
    return ExtractionModel(
      deviceId: json['deviceId'],
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
