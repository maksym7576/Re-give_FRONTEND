import 'package:flutter/material.dart';
import 'package:re_give_frontend/service/product_service.dart';

class ManageProductsComponent extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onProductDeleted;

  const ManageProductsComponent({
    Key? key,
    required this.product,
    required this.onProductDeleted,
  }) : super(key: key);

  void _deleteProduct(BuildContext context) async {
    try {
      await ProductService().deleteProduct(product['id']);
      onProductDeleted();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting product: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: product['imageUrl'] != null && product['imageUrl'].isNotEmpty
            ? Image.network(product['imageUrl'], width: 50, height: 50, fit: BoxFit.cover)
            : const Icon(Icons.image, size: 50, color: Colors.grey),
        title: Text(product['name']),
        subtitle: Text(product['description']),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _deleteProduct(context),
        ),
      ),
    );
  }
}
