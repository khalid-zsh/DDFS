import 'package:flutter/material.dart';

class CloudScreen extends StatelessWidget {
  const CloudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud'),
      ),
      body: Center(
        child: Text('Cloud Screen'),
      ),
    );
  }
}