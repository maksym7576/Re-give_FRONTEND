import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:re_give_frontend/service/auth_service.dart';
import '../api_config.dart';

class ProductService {
  AuthService authService = AuthService();

  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('https://getallproducts-zdp7bbrq4a-uc.a.run.app'));
    if(response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Map<String, dynamic>> createProduct(Map<String, dynamic> productData) async {
    String? token = await authService.getToken();

    final response = await http.post(
      Uri.parse('https://createproduct-zdp7bbrq4a-uc.a.run.app'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(productData),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Error creating product: ${response.body}');
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

  Future<Map<String, dynamic>> updateProduct(String productId, Map<String, dynamic> productData) async {
    String? token = await authService.getToken();
    final response = await http.put(
      Uri.parse('https://updateproduct-zdp7bbrq4a-uc.a.run.app/$productId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(productData),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Error updating product: ${response.body}');
    }
  }

  Future<String> deleteProduct(String productId) async {
    String? token = await authService.getToken();

    final response = await http.delete(
      Uri.parse('https://deleteproduct-zdp7bbrq4a-uc.a.run.app/$productId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData['message'];
    } else {
      throw Exception('Error deleting product: ${response.body}');
    }
  }
}