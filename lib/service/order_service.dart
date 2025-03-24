import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_config.dart';

class OrderService {

  Future<List<Map<String, dynamic>>> fetchAllOrdersByUserUid() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/products'));
    if(response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}