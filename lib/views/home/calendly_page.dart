import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CalendlyPage extends StatefulWidget {
  const CalendlyPage({super.key});

  @override
  _CalendlyPageState createState() => _CalendlyPageState();
}

class _CalendlyPageState extends State<CalendlyPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse("https://calendly.com/your-link"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Schedule an Appointment")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
