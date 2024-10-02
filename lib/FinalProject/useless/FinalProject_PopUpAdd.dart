// import 'package:flutter/material.dart';

// class practice extends StatefulWidget {
//   const practice({super.key});

//   @override
//   State<practice> createState() => _PracticeState();
// }

// class _PracticeState extends State<practice> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           Container(
//             child: InkWell(
//               onTap: () {
//                 popUpAddBook();
//               },
//               child: Container(
//                 padding: EdgeInsets.all(12),
//                 color: Colors.blue,
//                 child: Text(
//                   "Add Book",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void popUpAddBook() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Container(
//             width: double.maxFinite, // Allows the dialog to expand as needed
//             child: ListView(
//               shrinkWrap: true, // To avoid the infinite height issue
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: Stack(
//                     children: [
//                       Container(
//                         width: 100,
//                         height: 150,
//                         child: Image.asset(
//                           'assets/bookDefault.jpg',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 5,
//                         right: 5,
//                         child: Icon(Icons.camera_alt),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       TextField(
//                         decoration: InputDecoration(
//                           labelText: "Enter Book Title",
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       TextField(
//                         decoration: InputDecoration(
//                           labelText: "Enter Author",
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       InkWell(
//                         onTap: () {
//                           Navigator.of(context).pop(); // Close the dialog
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(12),
//                           color: Colors.blue,
//                           child: Text(
//                             "Add Book",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
