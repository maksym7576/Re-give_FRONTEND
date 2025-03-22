import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  final String apiUrl = 'http://127.0.0.1:5001/library-project-af8ca/us-central1/api';

  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('$apiUrl/products'));
    if(response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load products');
    }
  }
}