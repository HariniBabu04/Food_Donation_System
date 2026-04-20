import 'package:flutter/material.dart';
import '../agents/auth_agent.dart';
import '../models/user.dart';
import 'register_screen.dart';
import 'donor_dashboard.dart';
import 'seeker_dashboard.dart';
import '../services/storage_service.dart';
import '../agents/voice_agent.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'DONOR';
  final AuthAgent _authAgent = AuthAgent();
  final VoiceAgent _voiceAgent = VoiceAgent();
  bool _isLoading = false;
  bool _biometricEnabled = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricPreference();
  }

  void _checkBiometricPreference() async {
    final enabled = await StorageService.isBiometricEnabled();
    if (enabled) {
      final credentials = await StorageService.getCredentials();
      if (credentials != null) {
        _emailController.text = credentials['email']!;
        _selectedRole = credentials['role']!;
      }
    }
    setState(() => _biometricEnabled = enabled);
  }

  void _listenForCommand() {
    if (_isListening) {
      _voiceAgent.stopListening();
      setState(() => _isListening = false);
    } else {
      setState(() => _isListening = true);
      _voiceAgent.startListening((command) {
        setState(() => _isListening = false);
        if (command.contains("login") || command.contains("sign in")) {
          _voiceAgent.speak("Attempting to login.");
          _handleLogin();
        } else if (command.contains("biometric") || command.contains("scan") || command.contains("fingerprint")) {
          _voiceAgent.speak("Starting biometric authentication.");
          _handleBiometricLogin();
        } else if (command.contains("register") || command.contains("sign up")) {
          _voiceAgent.speak("Navigating to registration.");
          Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
        } else {
          _voiceAgent.speak("Command not recognized. Try 'login', 'scan', or 'register'.");
        }
      });
    }
  }

  void _handleLogin() async {
    setState(() => _isLoading = true);
    final result = await _authAgent.login(
      _emailController.text,
      _passwordController.text,
      _selectedRole,
    );
    setState(() => _isLoading = false);

    if (result['success']) {
      User user = result['user'];
      _navigateToDashboard(user);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }

  void _handleBiometricLogin() async {
    bool authenticated = await _authAgent.authenticateBiometrically();
    if (authenticated) {
      final credentials = await StorageService.getCredentials();
      if (credentials != null) {
        setState(() => _isLoading = true);
        final result = await _authAgent.login(
          credentials['email']!,
          credentials['password']!,
          credentials['role']!,
        );
        setState(() => _isLoading = false);

        if (result['success']) {
          _navigateToDashboard(result['user']);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Biometric login failed: ${result['message']}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No stored credentials. Please login manually first.")),
        );
      }
    }
  }

  void _navigateToDashboard(User user) {
    if (user.role?.toUpperCase() == 'DONOR') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DonorDashboard(user: user)));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SeekerDashboard(user: user)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal, Colors.tealAccent],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.volunteer_activism, size: 64, color: Colors.teal),
                    const SizedBox(height: 16),
                    const Text(
                      "Welcome Back",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      decoration: InputDecoration(
                        labelText: "I am a...",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'DONOR', child: Text("Donor")),
                        DropdownMenuItem(value: 'NGO', child: Text("Seeker (NGO)")),
                      ],
                      onChanged: (val) => setState(() => _selectedRole = val!),
                    ),
                    const SizedBox(height: 32),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("LOGIN"),
                          ),
                    const SizedBox(height: 16),
                    IconButton(
                      onPressed: _listenForCommand,
                      icon: Icon(_isListening ? Icons.mic : Icons.mic_none, size: 32, color: _isListening ? Colors.red : Colors.teal),
                      tooltip: "Voice Command (Try 'login' or 'scan')",
                    ),
                    const SizedBox(height: 8),
                    if (_biometricEnabled)
                      IconButton(
                        onPressed: _handleBiometricLogin,
                        icon: const Icon(Icons.fingerprint, size: 48, color: Colors.teal),
                        tooltip: "Login with Biometrics",
                      ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                      child: const Text("Don't have an account? Register"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
