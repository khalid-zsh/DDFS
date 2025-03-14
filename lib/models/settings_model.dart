class SettingsModel {
  final String adminPassword;
  final String teamViewerId;
  final String zoomLink;
  final String chatbotApiKey;
  final String emailSender;

  SettingsModel({
    required this.adminPassword,
    required this.teamViewerId,
    required this.zoomLink,
    required this.chatbotApiKey,
    required this.emailSender,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      adminPassword: json['adminPassword'],
      teamViewerId: json['teamViewerId'],
      zoomLink: json['zoomLink'],
      chatbotApiKey: json['chatbotApiKey'],
      emailSender: json['emailSender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminPassword': adminPassword,
      'teamViewerId': teamViewerId,
      'zoomLink': zoomLink,
      'chatbotApiKey': chatbotApiKey,
      'emailSender': emailSender,
    };
  }
}
