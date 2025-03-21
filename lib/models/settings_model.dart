class SettingsModel {
  final String adminPassword;
  final String emailSender;
  final String adminEmail; // Add this line
  final String unitId;
  final String appointmentUrl;
  final String termsPdfPath;
  final String mobilePdfPath;
  final String tabletPdfPath;
  final String pcMacPdfPath;
  final String apiKey;
  final String organizationUuid;

  SettingsModel({
    required this.adminPassword,
    required this.emailSender,
    required this.adminEmail, // Add this line
    required this.unitId,
    required this.appointmentUrl,
    required this.termsPdfPath,
    this.mobilePdfPath = "assets/pdf/Phone Settings.pdf",
    this.tabletPdfPath = "assets/pdf/Tablet Settings.pdf",
    this.pcMacPdfPath = "assets/pdf/Computer Settings.pdf",
    required this.apiKey,
    required this.organizationUuid,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      adminPassword: json['adminPassword'],
      emailSender: json['emailSender'],
      adminEmail: json['adminEmail'], // Add this line
      unitId: json['unitId'],
      appointmentUrl: json['appointmentUrl'],
      termsPdfPath: json['termsPdfPath'],
      mobilePdfPath: json['mobilePdfPath'] ?? "assets/pdf/Phone Settings.pdf",
      tabletPdfPath: json['tabletPdfPath'] ?? "assets/pdf/Tablet Settings.pdf",
      pcMacPdfPath: json['pcMacPdfPath'] ?? "assets/pdf/Computer Settings.pdf",
      apiKey: json['apiKey'],
      organizationUuid: json['organizationUuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminPassword': adminPassword,
      'emailSender': emailSender,
      'adminEmail': adminEmail, // Add this line
      'unitId': unitId,
      'appointmentUrl': appointmentUrl,
      'termsPdfPath': termsPdfPath,
      'mobilePdfPath': mobilePdfPath,
      'tabletPdfPath': tabletPdfPath,
      'pcMacPdfPath': pcMacPdfPath,
      'apiKey': apiKey,
      'organizationUuid': organizationUuid,
    };
  }

  SettingsModel copyWith({
    String? adminPassword,
    String? emailSender,
    String? adminEmail, // Add this line
    String? unitId,
    String? appointmentUrl,
    String? termsPdfPath,
    String? mobilePdfPath,
    String? tabletPdfPath,
    String? pcMacPdfPath,
    String? apiKey,
    String? organizationUuid,
  }) {
    return SettingsModel(
      adminPassword: adminPassword ?? this.adminPassword,
      emailSender: emailSender ?? this.emailSender,
      adminEmail: adminEmail ?? this.adminEmail, // Add this line
      unitId: unitId ?? this.unitId,
      appointmentUrl: appointmentUrl ?? this.appointmentUrl,
      termsPdfPath: termsPdfPath ?? this.termsPdfPath,
      mobilePdfPath: mobilePdfPath ?? this.mobilePdfPath,
      tabletPdfPath: tabletPdfPath ?? this.tabletPdfPath,
      pcMacPdfPath: pcMacPdfPath ?? this.pcMacPdfPath,
      apiKey: apiKey ?? this.apiKey,
      organizationUuid: organizationUuid ?? this.organizationUuid,
    );
  }
}