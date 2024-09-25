import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class SignOut {
  final _signout = FirebaseAuth.instance;

  Future<void> signout() async {
    try {
      await _signout.signOut();
    } catch (e) {
      log("$e");
    }
  }
}
