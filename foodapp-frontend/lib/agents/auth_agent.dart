import 'package:local_auth/local_auth.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class AuthAgent {
  final LocalAuthentication auth = LocalAuthentication();

  Future<Map<String, dynamic>> login(String email, String password, String role) async {
    try {
      final response = await ApiService.post("/auth/login", {
        "email": email,
        "password": password,
        "role": role,
      });

      if (response['status'] == 'success') {
        User user = User.fromJson(response['user']);
        await StorageService.saveUser(user);
        await StorageService.saveCredentials(email, password, role);
        return {"success": true, "user": user};
      } else {
        return {"success": false, "message": response['message']};
      }
    } catch (e) {
      return {"success": false, "message": "Connection error: ${e.toString()}"};
    }
  }

  Future<bool> authenticateBiometrically() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();

      if (!canAuthenticate) return false;

      return await auth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> register(User user, String password) async {
    try {
      Map<String, dynamic> userData = user.toJson();
      userData['password'] = password;
      final response = await ApiService.post("/auth/register", userData);
      return {"success": response['status'] == 'success', "message": response['message']};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
