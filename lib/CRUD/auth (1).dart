import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<String> uploadImage(File imageFile, String id) async {
  // Create a storage reference
  Reference storageRef = FirebaseStorage.instance.ref().child('employeeImages/$id');

  // Upload the file
  UploadTask uploadTask = storageRef.putFile(imageFile);

  // Get the download URL
  TaskSnapshot taskSnapshot = await uploadTask;
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  return downloadUrl;
}

Future AddEmployeeDetails(Map<String, dynamic> employeeInfoMap, String id, File? imageFile) async {
  if (imageFile != null) {
    String imageUrl = await uploadImage(imageFile, id);
    employeeInfoMap['imageUrl'] = imageUrl; // Add the image URL to the document
  }
    return await FirebaseFirestore.instance
      .collection("employee")
      .doc(id)
      .set(employeeInfoMap);
}


  // Future AddEmployeeDetails(Map<String, dynamic> employeeInfoMap, String id) async{
  //   return await FirebaseFirestore.instance.
  //   collection("employee")
  //   .doc(id)
  //   .set(employeeInfoMap);

  // }

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async{
    return await FirebaseFirestore.instance.collection("employee").snapshots();
  }
  
  Future updateEmployeeDetail(String id, Map<String, dynamic> updateInfo)async{
    return await FirebaseFirestore.instance.collection("employee").doc(id).update(updateInfo);
  }


  Future deleteEmployeeDetail(String id)async{
    return await FirebaseFirestore.instance.collection("employee").doc(id).delete();
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;

    }catch(e){
    print('Error');

    }
    return null;
  }

    Future<User?> signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;

    }catch(e){
    print('Error');

    }
    return null;
  }
  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
