import 'package:flutter/material.dart';
import '../agents/donor_agent.dart';
import '../models/user.dart';
import '../models/donation.dart';
import '../services/storage_service.dart';
import 'login_screen.dart';
import 'settings_screen.dart';
import '../agents/voice_agent.dart';

class DonorDashboard extends StatefulWidget {
  final User user;
  const DonorDashboard({super.key, required this.user});

  @override
  _DonorDashboardState createState() => _DonorDashboardState();
}

class _DonorDashboardState extends State<DonorDashboard> {
  final DonorAgent _donorAgent = DonorAgent();
  final VoiceAgent _voiceAgent = VoiceAgent();
  List<Donation> _donations = [];
  bool _isLoading = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _loadDonations();
  }

  void _loadDonations() async {
    setState(() => _isLoading = true);
    final donations = await _donorAgent.getMyDonations(widget.user.userId!);
    setState(() {
      _donations = donations;
      _isLoading = false;
    });
  }

  void _listenForCommand() {
    if (_isListening) {
      _voiceAgent.stopListening();
      setState(() => _isListening = false);
    } else {
      setState(() => _isListening = true);
      _voiceAgent.startListening((command) {
        setState(() => _isListening = false);
        if (command.contains("post") || command.contains("add") || command.contains("new")) {
          _voiceAgent.speak("Opening add food dialog.");
          _showAddFoodDialog();
        } else if (command.contains("refresh") || command.contains("update")) {
          _voiceAgent.speak("Refreshing your donations.");
          _loadDonations();
        } else if (command.contains("settings") || command.contains("config") || command.contains("options")) {
          _voiceAgent.speak("Opening settings.");
          Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
        } else if (command.contains("logout") || command.contains("sign out") || command.contains("exit")) {
          _voiceAgent.speak("Logging you out. Goodbye!");
          StorageService.logout();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        } else {
          _voiceAgent.speak("Command not recognized. Try 'post food', 'refresh', 'settings', or 'logout'.");
        }
      });
    }
  }

  void _showAddFoodDialog() {
    final foodNameController = TextEditingController();
    final foodTypeController = TextEditingController();
    final quantityController = TextEditingController();
    final addressController = TextEditingController(text: widget.user.address);
    final contactPersonController = TextEditingController(text: widget.user.name);
    final contactNumberController = TextEditingController(text: widget.user.phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Post Food Availability"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: foodNameController, decoration: const InputDecoration(labelText: "Food Name")),
              TextField(controller: foodTypeController, decoration: const InputDecoration(labelText: "Food Type (Veg/Non-Veg)")),
              TextField(controller: quantityController, decoration: const InputDecoration(labelText: "Quantity"), keyboardType: TextInputType.number),
              TextField(controller: addressController, decoration: const InputDecoration(labelText: "Pickup Address")),
              TextField(controller: contactPersonController, decoration: const InputDecoration(labelText: "Contact Person")),
              TextField(controller: contactNumberController, decoration: const InputDecoration(labelText: "Contact Number")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final success = await _donorAgent.announceFoodAvailability(
                donorId: widget.user.userId!,
                foodName: foodNameController.text,
                foodType: foodTypeController.text,
                quantity: int.parse(quantityController.text),
                address: addressController.text,
                contactPerson: contactPersonController.text,
                contactNumber: contactNumberController.text,
              );
              if (success) {
                Navigator.pop(context);
                _loadDonations();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Food posted successfully!")));
              }
            },
            child: const Text("POST"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donor Dashboard"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
          IconButton(
            icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: _isListening ? Colors.red : Colors.white),
            onPressed: _listenForCommand,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              StorageService.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _donations.isEmpty
              ? const Center(child: Text("No donations posted yet."))
              : ListView.builder(
                  itemCount: _donations.length,
                  itemBuilder: (context, index) {
                    final d = _donations[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.fastfood, color: Colors.teal),
                        title: Text("${d.foodName} (${d.quantity})"),
                        subtitle: Text("Status: ${d.status}\nPickup: ${d.pickupAddress}"),
                        trailing: Icon(
                          d.status == 'ACCEPTED' ? Icons.check_circle : Icons.pending,
                          color: d.status == 'ACCEPTED' ? Colors.green : Colors.orange,
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFoodDialog,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
