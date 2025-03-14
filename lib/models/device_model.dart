class DeviceModel {
  final String id;
  final String name;
  final String type;
  final String status;

  DeviceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'status': status,
    };
  }
}
