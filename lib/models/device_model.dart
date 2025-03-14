class Device {
  final String id;
  final String type;
  final String name;

  Device({required this.id, required this.type, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
    };
  }
}