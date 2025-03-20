class SettingsModel {
  final String adminPassword;
  final String emailSender;
  final String unitId;
  final String appointmentUrl;
  final String termsPdfPath;
  final String mobilePdfPath;
  final String tabletPdfPath;
  final String pcMacPdfPath;

  SettingsModel({
    required this.adminPassword,
    required this.emailSender,
    required this.unitId,
    required this.appointmentUrl,
    required this.termsPdfPath,
    this.mobilePdfPath = "assets/pdf/Phone Settings.pdf",
    this.tabletPdfPath = "assets/pdf/Tablet Settings.pdf",
    this.pcMacPdfPath = "assets/pdf/Computer Settings.pdf",
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      adminPassword: json['adminPassword'],
      emailSender: json['emailSender'],
      unitId: json['unitId'],
      appointmentUrl: json['appointmentUrl'],
      termsPdfPath: json['termsPdfPath'],
      mobilePdfPath: json['mobilePdfPath'] ?? "assets/pdf/Phone Settings.pdf",
      tabletPdfPath: json['tabletPdfPath'] ?? "assets/pdf/Tablet Settings.pdf",
      pcMacPdfPath: json['pcMacPdfPath'] ?? "assets/pdf/Computer Settings.pdf",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminPassword': adminPassword,
      'emailSender': emailSender,
      'unitId': unitId,
      'appointmentUrl': appointmentUrl,
      'termsPdfPath': termsPdfPath,
      'mobilePdfPath': mobilePdfPath,
      'tabletPdfPath': tabletPdfPath,
      'pcMacPdfPath': pcMacPdfPath,
    };
  }

  SettingsModel copyWith({
    String? adminPassword,
    String? emailSender,
    String? unitId,
    String? appointmentUrl,
    String? termsPdfPath,
    String? mobilePdfPath,
    String? tabletPdfPath,
    String? pcMacPdfPath,
  }) {
    return SettingsModel(
      adminPassword: adminPassword ?? this.adminPassword,
      emailSender: emailSender ?? this.emailSender,
      unitId: unitId ?? this.unitId,
      appointmentUrl: appointmentUrl ?? this.appointmentUrl,
      termsPdfPath: termsPdfPath ?? this.termsPdfPath,
      mobilePdfPath: mobilePdfPath ?? this.mobilePdfPath,
      tabletPdfPath: tabletPdfPath ?? this.tabletPdfPath,
      pcMacPdfPath: pcMacPdfPath ?? this.pcMacPdfPath,
    );
  }
}