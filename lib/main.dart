import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:second_application/FinalProject/FinalProject_Cart.dart';
import 'package:second_application/FinalProject/FinalProject_Home.dart';
import 'package:second_application/FinalProject/FinalProject_Login.dart';
import 'package:second_application/FinalProject/FinalProject_Upcoming.dart';
import 'package:second_application/FinalProject/Profile.dart';
import 'package:second_application/FinalProject/FinalProject_API/FinalProject_CallAPIBook.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBG8L9R9ja97V7lwFQKgXDhaW0-H8iBoDs",
            authDomain: "cst9finalproject-c44c5.firebaseapp.com",
            projectId: "cst9finalproject-c44c5",
            storageBucket: "cst9finalproject-c44c5.appspot.com",
            messagingSenderId: "981315697596",
            appId: "1:981315697596:web:ceebc14594be67bef449b9"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      //home: BookList(),
      // home: FinalprojectUpcoming(),
      // home: FinalProjectHome(),
      // home: FinalprojectCart(),
      // home: FinalprojectProfile(),
      // home: MyWidget(),
      home: FinalprojectLogin(),
    );
  }

  // void main() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  //   runApp(MyApp());
  // }
}
