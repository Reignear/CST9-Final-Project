import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String _register_email, String _register_password) async {
    try {
      final _registration_credential =
          await _auth.createUserWithEmailAndPassword(
              email: _register_email, password: _register_password);
      return _registration_credential.user;
    } catch (e) {
      log("Something went wrong in registration! $e");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong! $e");
    }
  }
}
