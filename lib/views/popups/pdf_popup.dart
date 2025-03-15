import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';

class PdfPopup extends StatelessWidget {
  final String filePath;
  final bool isPdf;
  final VoidCallback onStartExtraction;

  const PdfPopup({
    super.key,
    required this.filePath,
    required this.isPdf,
    required this.onStartExtraction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          AppBar(title: const Text("Guide Viewer"), automaticallyImplyLeading: false),
          Expanded(
            child: isPdf
                ? SfPdfViewer.file(
              File(filePath),
            ) // Load PDF
                : Image.asset(filePath, fit: BoxFit.contain),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onStartExtraction(); // Call the callback
              },
              child: const Text("Get Started"),
            ),
          ),
        ],
      ),
    );
  }
}