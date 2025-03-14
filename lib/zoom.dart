import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ZoomScreen extends StatefulWidget {
  const ZoomScreen({super.key});

  @override
  _ZoomScreenState createState() => _ZoomScreenState();
}

class _ZoomScreenState extends State<ZoomScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse("https://zoom.us/join"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Join Zoom Meeting")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
