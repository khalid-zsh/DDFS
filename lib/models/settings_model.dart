class SettingsModel {
  final String adminPassword;
  final String emailSender;
  final String zoomLink;
  final String chatbotApiKey;

  SettingsModel({
    required this.adminPassword,
    required this.emailSender,
    required this.zoomLink,
    required this.chatbotApiKey,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      adminPassword: json['adminPassword'],
      emailSender: json['emailSender'],
      zoomLink: json['zoomLink'],
      chatbotApiKey: json['chatbotApiKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminPassword': adminPassword,
      'emailSender': emailSender,
      'zoomLink': zoomLink,
      'chatbotApiKey': chatbotApiKey,
    };
  }
}