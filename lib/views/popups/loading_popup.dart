import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/teamviewer_service.dart';

class LoadingPopup extends StatefulWidget {
  const LoadingPopup({super.key});

  @override
  _LoadingPopupState createState() => _LoadingPopupState();
}

class _LoadingPopupState extends State<LoadingPopup> {
  bool isExtractionComplete = false;

  @override
  void initState() {
    super.initState();
    _monitorTeamViewerSession(); // Start monitoring TeamViewer session
  }

  void _monitorTeamViewerSession() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 5)); // Check every 5 seconds

      bool isSessionActive = await TeamViewerService.isSessionActive();
      if (!isSessionActive) {
        setState(() {
          isExtractionComplete = true;
        });
        break;
      }
    }
  }

  void _exitLoadingScreen() {
    if (isExtractionComplete) {
      Get.offAllNamed('/home'); // Navigate back to Home Page
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevents user from exiting the pop-up
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Colors.blue),
                  const SizedBox(height: 20),
                  const Text(
                    "Data Extraction Process is On...",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  if (isExtractionComplete)
                    ElevatedButton(
                      onPressed: _exitLoadingScreen,
                      child: const Text("Close"),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
