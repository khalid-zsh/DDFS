import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppointmentService {
  static Widget loadCalendly() {
    return WebViewWidget(controller: WebViewController()..loadRequest(Uri.parse("https://calendly.com/your-link")));
  }
}
