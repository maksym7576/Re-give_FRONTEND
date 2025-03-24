import 'package:flutter/material.dart';
import 'package:re_give_frontend/screens/home_page.dart';
import '../screens/auth_screen.dart';
import '../screens/main_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppRouter {
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _tokenExpiryKey = 'token_expiry';

  static Future<bool> isAuthenticated() async {
    String? token = await _secureStorage.read(key: _tokenKey);
    String? expiryTimeString = await _secureStorage.read(key: _tokenExpiryKey);
    if (token == null || expiryTimeString == null) {
      print('Token or "expire time" is null');
      return false;
    }

    DateTime expiryTime = DateTime.parse(expiryTimeString);
    if (DateTime.now().isAfter(expiryTime)) {
      print('Token is expired');
      return false;
    }
    print('Login or register made perfect');
    return true;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => FutureBuilder<bool>(
        future: isAuthenticated(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          bool authenticated = snapshot.data ?? false;

          if (!authenticated && settings.name != '/auth') {
            return AuthScreen();
          }

          if (authenticated && settings.name == '/') {
            return HomePage();
          }

          switch (settings.name) {
            case '/':
              return HomePage();
            case '/auth':
              return AuthScreen();
            default:
              return Scaffold(
                body: Center(child: Text('No route defined for ${settings.name}')),
              );
          }
        },
      ),
    );
  }
}