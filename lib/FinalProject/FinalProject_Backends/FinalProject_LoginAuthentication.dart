import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class LoginService {
  final _LoginAuth = FirebaseAuth.instance;

  Future<User?> loginUserWithEmailAndPassword(
      String _login_email, String _login_password) async {
    try {
      final _login_credential = await _LoginAuth.signInWithEmailAndPassword(
          email: _login_email, password: _login_password);
      return _login_credential.user;
    } catch (e) {
      log("Something went wrong in login! $e");
    }
    return null;
  }
}
