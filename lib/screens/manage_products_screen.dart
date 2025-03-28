import 'package:flutter/material.dart';
import '../service/product_service.dart';
import '../components/manage_products_component.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({Key? key}) : super(key: key);

  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  final ProductService productService = ProductService();
  late Future<List<Map<String, dynamic>>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = productService.fetchUserProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data!.isEmpty) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products available'));
                }

                List<Map<String, dynamic>> products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ManageProductsComponent(product: products[index]);
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                print("Botón presionado");
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
