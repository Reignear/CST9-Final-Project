import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<String?> getUserName(String uid) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc.exists && userDoc.data() != null
        ? userDoc.data()!['name']
        : null;
  }

  Future<Stream<QuerySnapshot>> getBookDetails() async {
    return await FirebaseFirestore.instance.collection("books").snapshots();
  }
}
