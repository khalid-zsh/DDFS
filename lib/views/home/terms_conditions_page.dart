import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TermsConditionsPage extends StatelessWidget {
  final Widget? nextPage;
  final bool showButtons;
  final String? termsKey;

  const TermsConditionsPage({super.key, this.nextPage, this.showButtons = true, this.termsKey});

  Future<void> _acceptTerms(BuildContext context) async {
    if (termsKey != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(termsKey!, true);
    }
    if (nextPage != null) {
      // Use Get.off to remove the TermsConditionsPage from the navigation stack
      Get.off(() => nextPage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms and Conditions')),
      body: Column(
        children: [
          Expanded(
            child: SfPdfViewer.asset('assets/pdf/DDFS CONCENT FORM DRAFT MATCH 2025 V1.pdf'),
          ),
          if (showButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _acceptTerms(context),
                  child: const Text('Agree'),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Disagree'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}