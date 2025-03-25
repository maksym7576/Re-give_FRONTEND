import 'package:flutter/material.dart';
import 'package:re_give_frontend/service/order_service.dart';

class ProductComponent extends StatelessWidget {
  final Map<String, dynamic> product;
  final OrderService orderService = OrderService();

  ProductComponent({Key? key, required this.product}) : super(key: key);

  Future<void> _handleOrder(BuildContext context) async {
    String? productId = product['id'];
    if (productId == null || productId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product ID is missing')),
      );
      return;
    }
    String response = await orderService.createAnOrder(productId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            leading: product['imageUrl'] !=null && product['imageUrl'].isNotEmpty
                ? Image.network(product['imageUrl'], width: 50, height: 50, fit: BoxFit.cover)
                : Icon(Icons.image_not_supported),
            title: Text(product['name'], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(product['description']),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () => _handleOrder(context),
              child: Text('Ask'),
            ),
          )
        ],
      ),
    );
  }
}
