import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  String zoomAccount = '';
  String teamViewerAccount = '';
  String emailAccount = '';
  String chatBotCredentials = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Zoom Account'),
                onSaved: (value) {
                  zoomAccount = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'TeamViewer Account'),
                onSaved: (value) {
                  teamViewerAccount = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email Account'),
                onSaved: (value) {
                  emailAccount = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'ChatBot Credentials'),
                onSaved: (value) {
                  chatBotCredentials = value ?? '';
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save settings
                  }
                },
                child: Text('Save Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}