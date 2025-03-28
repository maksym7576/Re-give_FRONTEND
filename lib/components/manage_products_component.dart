import 'package:flutter/material.dart';

class ManageProductsComponent extends StatelessWidget {
  final Map<String, dynamic> product;

  ManageProductsComponent({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 3),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    color:
                        product['imageUrl'] == null || product['imageUrl'] == ''
                            ? Colors.grey[300]
                            : null,
                    image:
                        product['imageUrl'] != null && product['imageUrl'] != ''
                            ? DecorationImage(
                              image: NetworkImage(product['imageUrl']),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child:
                      product['imageUrl'] == null || product['imageUrl'] == ''
                          ? Center(
                            child: Text(
                              'No Image',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          )
                          : null,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '26.01.2025',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
