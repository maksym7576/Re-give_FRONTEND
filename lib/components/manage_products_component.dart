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

  void _showUpdateProductDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: product['name']);
    TextEditingController descriptionController = TextEditingController(text: product['description']);
    TextEditingController imageUrlController = TextEditingController(text: product['imageUrl']);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update Product"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
                TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Description")),
                TextField(controller: imageUrlController, decoration: const InputDecoration(labelText: "Image URL")),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty || descriptionController.text.isEmpty || imageUrlController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                  return;
                }
                Map<String, dynamic> updatedProduct = {
                  "name": nameController.text,
                  "description": descriptionController.text,
                  "imageUrl": imageUrlController.text,
                };
                try {
                  await ProductService().updateProduct(product['id'], updatedProduct);
                  Navigator.pop(context);
                  onProductDeleted();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product updated successfully")));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error updating product: $e")));
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showUpdateProductDialog(context)),
            IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteProduct(context)),
          ],
        ),
      ),
    );
  }
}
