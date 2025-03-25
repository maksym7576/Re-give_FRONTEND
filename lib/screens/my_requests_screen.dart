import 'package:flutter/material.dart';
import 'package:re_give_frontend/service/order_service.dart';

class MyRequestsScreen extends StatelessWidget {
  final OrderService orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: orderService.fetchAllOrdersByUserUid(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No orders found'));
        } else {
          List<Map<String, dynamic>> orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final isAccepted = order['isAccepted'];
              final isFinished = order['isFinished'];

              String status = 'Pending';
              if (isAccepted) {
                status = 'Accepted';
              } else if (isFinished) {
                status = 'Finished';
              }
              return Card(
                margin: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                child: ListTile(
                  leading: order['imageUrl'] != null
                      ? Image.network(order['imageUrl'], width: 50, height: 50, fit: BoxFit.cover)
                      : Icon(Icons.image_not_supported),
                  title: Text(order['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(order['description']),
                  trailing: Text(status),
                ),
              );
            },
          );
        }
      },
    );
  }
}