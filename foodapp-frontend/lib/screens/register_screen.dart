import 'package:flutter/material.dart';
import '../agents/auth_agent.dart';
import '../models/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _orgController = TextEditingController();
  final _addressController = TextEditingController();
  String _selectedRole = 'DONOR';
  final AuthAgent _authAgent = AuthAgent();
  bool _isLoading = false;

  void _handleRegister() async {
    setState(() => _isLoading = true);
    final user = User(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      role: _selectedRole,
      organizationName: _orgController.text,
      address: _addressController.text,
    );

    final result = await _authAgent.register(user, _passwordController.text);
    setState(() => _isLoading = false);

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful! Please login.")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account"), backgroundColor: Colors.teal, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Full Name")),
            const SizedBox(height: 16),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
            const SizedBox(height: 16),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: "Phone")),
            const SizedBox(height: 16),
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: const InputDecoration(labelText: "Register as"),
              items: const [
                DropdownMenuItem(value: 'DONOR', child: Text("Donor")),
                DropdownMenuItem(value: 'NGO', child: Text("Seeker (NGO)")),
              ],
              onChanged: (val) => setState(() => _selectedRole = val!),
            ),
            const SizedBox(height: 16),
            TextField(controller: _orgController, decoration: const InputDecoration(labelText: "Organization Name (Optional)")),
            const SizedBox(height: 16),
            TextField(controller: _addressController, decoration: const InputDecoration(labelText: "Address")),
            const SizedBox(height: 32),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                    child: const Text("REGISTER"),
                  ),
          ],
        ),
      ),
    );
  }
}
