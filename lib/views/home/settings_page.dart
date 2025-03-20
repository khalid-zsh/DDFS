import 'package:ddfs/controllers/settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsController _settingsController;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController unitIdController = TextEditingController();

  final TextEditingController appointmentUrlController = TextEditingController();

  RxString pdfPath1 = ''.obs;

  RxString pdfPath2 = ''.obs;

  RxString pdfPath3 = ''.obs;

  RxString termsPdfPath = ''.obs;

  @override
  void initState() {
    super.initState();
    _settingsController = Get.find<SettingsController>();
  }

  void _pickFile(RxString pdfPath) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      pdfPath.value = result.files.single.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Settings", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                _buildSectionTitle("Admin Settings"),
                _buildTextField(emailController, "Change Email", Icons.email),
                _buildSaveButton("Save Email", () {
                  _settingsController.updateEmailSender(emailController.text);
                  emailController.clear();
                }),

                _buildTextField(passwordController, "New Password", Icons.lock, obscureText: true),
                _buildTextField(confirmPasswordController, "Confirm Password", Icons.lock, obscureText: true),
                _buildSaveButton("Save Password", () {
                  if (passwordController.text == confirmPasswordController.text) {
                    _settingsController.updateAdminPassword(passwordController.text);
                    passwordController.clear();
                    confirmPasswordController.clear();
                    Get.snackbar("Success", "Password Updated", backgroundColor: Colors.green);
                  } else {
                    Get.snackbar("Error", "Passwords do not match", backgroundColor: Colors.red);
                  }
                }),

                _buildTextField(unitIdController, "Change Unit ID", Icons.vpn_key),
                _buildSaveButton("Save Unit ID", () {
                  _settingsController.updateUnitId(unitIdController.text);
                  unitIdController.clear();
                }),

                _buildSectionTitle("Upload PDFs"),
                _buildFileUploadField("Mobile Data Extraction PDF", pdfPath1),
                _buildFileUploadField("Tablet Data Extraction PDF", pdfPath2),
                _buildFileUploadField("PC or Mac Data Extraction PDF", pdfPath3),
                _buildSaveButton("Save PDFs", () {
                  if (pdfPath1.isNotEmpty) _settingsController.updatePdfPath("Mobile Phone", pdfPath1.value);
                  if (pdfPath2.isNotEmpty) _settingsController.updatePdfPath("Tablet", pdfPath2.value);
                  if (pdfPath3.isNotEmpty) _settingsController.updatePdfPath("PC or Mac", pdfPath3.value);
                  pdfPath1.value = '';
                  pdfPath2.value = '';
                  pdfPath3.value = '';
                  Get.snackbar("Success", "PDFs Updated", backgroundColor: Colors.green);
                }),

                _buildSectionTitle("Terms & Conditions PDF"),
                _buildFileUploadField("Terms & Conditions PDF", termsPdfPath),
                _buildSaveButton("Save Terms & Conditions PDF", () {
                  if (termsPdfPath.isNotEmpty) _settingsController.updateTermsPdfPath(termsPdfPath.value);
                  termsPdfPath.value = '';
                  Get.snackbar("Success", "Terms & Conditions PDF Updated", backgroundColor: Colors.green);
                }),

                _buildSectionTitle("Appointment URL Change"),
                _buildTextField(appointmentUrlController, "New Appointment URL", Icons.link),
                _buildSaveButton("Save Appointment URL", () {
                  _settingsController.updateAppointmentUrl(appointmentUrlController.text);
                  appointmentUrlController.clear();
                  Get.snackbar("Success", "Appointment URL Updated", backgroundColor: Colors.green);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildSaveButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  Widget _buildFileUploadField(String label, RxString filePath) {
    return Obx(() => ListTile(
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(filePath.value.isEmpty ? "No file selected" : filePath.value, style: const TextStyle(color: Colors.grey)),
      trailing: ElevatedButton.icon(
        icon: const Icon(Icons.upload_file, color: Colors.white),
        label: const Text("Upload", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
        onPressed: () => _pickFile(filePath),
      ),
    ));
  }
}