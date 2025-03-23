import 'package:flutter/material.dart';
import 'package:re_give_frontend/screens/main_screen.dart';
import 'package:re_give_frontend/screens/my_requests_screen.dart';
import 'package:re_give_frontend/screens/requests_screen.dart';
import 'package:re_give_frontend/screens/manage_products_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MainScreen(),
    MyRequestsScreen(),
    RequestsScreen(),
    ManageProductsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      // backgroundColor: Colors.black87,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black12,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'My Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Manage Products',
          ),
        ],
      ),
    );
  }
}
