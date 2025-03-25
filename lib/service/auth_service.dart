import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveUserData(data);
      return data;
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }
  
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveUserData(data);
      return data;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

    Future<void> _saveUserData(Map<String, dynamic> data) async {
      final String token = data['token'];
      final String uid = data['uid'];
      final String role = data['role'];
      final expiryDate = DateTime.now().add(Duration(days: 1));
      await secureStorage.write(key: 'auth_token', value: token);
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('user_uid', uid);
      await preferences.setString('user_role', role);
      await secureStorage.write(
        key: 'token_expiry',
        value: expiryDate.toIso8601String(),
      );
    }

    Future<String?> getUserUID() async {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      return preferences.getString('user_uid');
    }

}