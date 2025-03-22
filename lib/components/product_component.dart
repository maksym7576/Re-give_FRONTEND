import 'package:flutter/material.dart';

class ProductComponent extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductComponent({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: ListTile(
        leading: product['_imageUrl'] != null && product['_imageUrl'].isNotEmpty
            ? Image.network(product['_imageUrl'], width: 50, height: 50, fit: BoxFit.cover)
            : Icon(Icons.image_not_supported),
        title: Text(product['_name'], style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(product['_description']),
      ),
    );
  }
}
