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
    return Center(
      child: Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4, spreadRadius: 1),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter'),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Username',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '26.01.2025',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 3),
              Text(
                product['name'] ?? 'without name',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                product['description'] ?? 'without description',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 3),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 300,
                  width: 500,
                  decoration: BoxDecoration(
                    color: product['imageUrl'] == null || product['imageUrl'] == ''
                        ? Colors.grey[300]
                        : null,
                    image: product['imageUrl'] != null && product['imageUrl'] != ''
                        ? DecorationImage(
                      image: NetworkImage(product['imageUrl']),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: product['imageUrl'] == null || product['imageUrl'] == ''
                      ? Center(
                    child: Text(
                      'No Image',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  )
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => _handleOrder(context),
                  child: const Text('Order'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
