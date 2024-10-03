import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class LoginService {
  static final FirebaseAuth _LoginAuth = FirebaseAuth.instance;

  static Future<User?> loginUserWithEmailAndPassword(
      String loginEmail, String loginPassword) async {
    try {
      final _loginCredential = await _LoginAuth.signInWithEmailAndPassword(
          email: loginEmail, password: loginPassword);
      return _loginCredential.user;
    } catch (e) {
      log("Something went wrong in login! $e");
    }
    return null;
  }
}
