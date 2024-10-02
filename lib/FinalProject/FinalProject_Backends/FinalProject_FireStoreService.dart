import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getBookDetails() {
    return _firestore.collection('books').snapshots();
  }

  Future<String?> getUserName(String uid) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc.exists && userDoc.data() != null
        ? userDoc.data()!['name']
        : null;
  }
}
