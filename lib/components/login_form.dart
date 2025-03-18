import 'package:flutter/material.dart';
import '../service/auth_service.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String message = '';
  String? token = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final result = await _authService.login(email, password);
        setState(() {
          token = result['token'];
          message = 'Login successful! Token stored.';
        });
      } catch (e) {
        setState(() {
          message = 'Login failed: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (val) => email = val,
              validator: (val) => val!.isEmpty ? 'Please enter the email' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (val) => password = val,
              validator: (val) =>
              val!.isEmpty
                  ? 'Please enter the password'
                  : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: Text('Login')),
            SizedBox(height: 20),
            Text(message)
          ],
        )),
    );
  }
}