import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../agents/auth_agent.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometricEnabled = false;
  final AuthAgent _authAgent = AuthAgent();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    final enabled = await StorageService.isBiometricEnabled();
    setState(() => _biometricEnabled = enabled);
  }

  void _toggleBiometric(bool value) async {
    if (value) {
      // Authenticate biometrically before enabling
      bool authenticated = await _authAgent.authenticateBiometrically();
      if (authenticated) {
        await StorageService.setBiometricEnabled(true);
        setState(() => _biometricEnabled = true);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Biometric login enabled.")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Authentication failed. Cannot enable biometrics.")));
      }
    } else {
      await StorageService.setBiometricEnabled(false);
      setState(() => _biometricEnabled = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Biometric login disabled.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Enable Biometric Login"),
            subtitle: const Text("Use fingerprint or face recognition to login."),
            value: _biometricEnabled,
            onChanged: _toggleBiometric,
            secondary: const Icon(Icons.fingerprint, color: Colors.teal),
          ),
        ],
      ),
    );
  }
}
