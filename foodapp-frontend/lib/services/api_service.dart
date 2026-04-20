import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiService {
  static String get baseUrl {
    if (kIsWeb) return "http://localhost:8085/api";
    if (Platform.isAndroid) return "http://10.120.38.138:8085/api"; // Your local IP
    return "http://localhost:8085/api";
  }

  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final String url = "$baseUrl$endpoint";
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    return jsonDecode(response.body);
  }

  static Future<dynamic> get(String endpoint) async {
    final String url = "$baseUrl$endpoint";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }
}
