import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:re_give_frontend/service/auth_service.dart';
import '../api_config.dart';

class OrderService {
  final AuthService authService = AuthService();

  // Future<List<Map<String, dynamic>>> fetchAllOrdersByUserUid() async {
  //   final response = await http.get(Uri.parse('https://getallorderswithproductsbyuseruid-zdp7bbrq4a-uc.a.run.app'));
  //   if(response.statusCode == 200) {
  //     List<dynamic> jsonData = json.decode(response.body);
  //     return jsonData.cast<Map<String, dynamic>>();
  //   } else {
  //     throw Exception('Failed to load orders');
  //   }
  // }

  Future<String> createAnOrder(String productId) async {
    final userUid = await authService.getUserUID();
    try {
      final body = json.encode({
        'productId': productId,
        'userId': userUid,
      });
      await http.post(
        Uri.parse('https://createorder-zdp7bbrq4a-uc.a.run.app'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
        return "Order created";
    } catch (e) {
      return "Error occurred";
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllOrdersByUserUid() async {
    final userUid = await authService.getUserUID();
    final response = await http.get(Uri.parse('https://getallorderswithproductsbyuseruid-zdp7bbrq4a-uc.a.run.app/${userUid}'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load orders');
    }
  }

}