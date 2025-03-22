import 'package:flutter/material.dart';
import 'package:re_give_frontend/navigators/AppRouter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Auth Demo',
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
