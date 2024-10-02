import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<User?> createUserWithEmailAndPassword(
      String _register_email, String _register_password, String _name) async {
    try {
      final _registration_credential =
          await _auth.createUserWithEmailAndPassword(
              email: _register_email, password: _register_password);

      await _firestore
          .collection('users')
          .doc(_registration_credential.user?.uid)
          .set({
        'email': _register_email,
        'name': _name,
      });

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
