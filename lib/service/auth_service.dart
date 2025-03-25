import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_config.dart';

class AuthService {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        final token = await user.getIdToken();
        final uid = user.uid;
        final role = 'user';
        await saveUserData(token, uid, role);

        return {
          'token': token,
          'uid': uid,
          'role': role,
          'email': user.email,
          // Додаткова інформація з Firebase Auth
          'emailVerified': user.emailVerified,
          'createdAt': user.metadata.creationTime?.toIso8601String()
        };
      } else {
        throw Exception('Registration failed');
      }
    } catch (error) {
      throw Exception('Registration failed: $error');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      final user = userCredential.user;
      if (user != null) {
        final token = await user.getIdToken();
        final uid = user.uid;

        final role = 'user';

        await saveUserData(token, uid, role);

        return {
          'token': token,
          'uid': uid,
          'role': role,
          'email': user.email,
          'emailVerified': user.emailVerified,
          'lastLogin': user.metadata.lastSignInTime?.toIso8601String()
        };
      } else {
        throw Exception('User is null');
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      print('Unknown error: $e');
      throw Exception('Login failed: Unknown error');
    }
  }

  Future<String?> getUserUID() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('user_uid');
  }

  Future<void> signOut() async {
    await auth.signOut();
    await secureStorage.delete(key: 'auth_token');
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user_uid');
    await preferences.remove('user_role');
  }

  Future<void> saveUserData(String? token, String? uid, String role) async {
    if (token == null || uid == null) {
      throw Exception('Token or UID is null');
    }

    final expiryDate = DateTime.now().add(Duration(days: 1));
    await secureStorage.write(key: 'auth_token', value: token);

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('user_uid', uid);
    await preferences.setString('user_role', role);

    await secureStorage.write(
      key: 'token_expiry',
      value: expiryDate.toIso8601String(),
    );
  }
}