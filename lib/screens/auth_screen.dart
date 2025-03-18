import 'package:flutter/material.dart';
import '../components/login_form.dart';
import '../components/register_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text('Auth Screen'),
    bottom: TabBar(
      controller: _tabController,
      tabs: [
        Tab(text: 'Login'),
        Tab(text: 'Register'),
      ],
  ),
    ),
  body: TabBarView(
    controller: _tabController,
    children: [
      LoginForm(),
      RegisterForm(),
  ],
    ),
  );
  }
}