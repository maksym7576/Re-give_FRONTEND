import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:re_give_frontend/service/auth_service.dart';
import '../api_config.dart';

class ProductService {
  AuthService authService = AuthService();

  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/products'));
    if(response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Map<String, dynamic>>> fetchUserProducts() async {
    String? token = await authService.getToken();
    final response = await http.get(
      Uri.parse('https://getallproductsbyuser-zdp7bbrq4a-uc.a.run.app'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error loading user products: ${response.body}');
    }
  }
}