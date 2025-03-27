import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_config.dart';

class ProductService {

  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('https://getallproducts-zdp7bbrq4a-uc.a.run.app'));
    if(response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load products');
    }
  }

}