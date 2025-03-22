import 'package:flutter/material.dart';
import 'package:re_give_frontend/screens/home_page.dart';
import '../screens/auth_screen.dart';
import '../screens/main_screen.dart';

class AppRouter {
  static bool get isAuthenticated {
    return true;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (!isAuthenticated && settings.name != '/auth') {
      return MaterialPageRoute(builder: (_) => AuthScreen());
    }

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/auth':
        return MaterialPageRoute(builder: (_) => AuthScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
