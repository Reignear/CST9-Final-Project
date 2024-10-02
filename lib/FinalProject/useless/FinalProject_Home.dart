// import 'package:flutter/material.dart';
// import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_CRUD.dart';
// import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_SignOut.dart';
// import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Cart.dart';
// import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Favorite.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Login.dart';
// import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_ReadBook.dart';
// import 'package:second_application/FinalProject/FinalProject_UI_Methods.dart';

// class FinalProjectHome extends StatefulWidget {
//   const FinalProjectHome({super.key});

//   @override
//   State<FinalProjectHome> createState() => _FinalProjectHomeState();
// }

// class _FinalProjectHomeState extends State<FinalProjectHome> {
//   int _selectedIndex = 0;
//   final List<Widget> _pages = [
//     HomeScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: HomeAppBar(context),
//       // drawer: customDrawer(context),
//       body: _pages[_selectedIndex],
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black,
//       child: ListView(
//         children: [
//           SectionTitle(title: 'Continue Reading'),
//           BookList(),
//           SectionTitle(title: 'Top Picks for You'),
//           BookList(),
//           SectionTitle(title: 'Top Books in the Philippines'),
//           BookList(),
//           SectionTitle(title: 'Books for sale'),
//           BookList(),
//         ],
//       ),
//     );
//   }
// }

// class SectionTitle extends StatefulWidget {
//   final String title;

//   const SectionTitle({required this.title});

//   @override
//   State<SectionTitle> createState() => _SectionTitleState();
// }

// class _SectionTitleState extends State<SectionTitle> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//       child: Text(
//         widget.title,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

// class BookList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 250,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () {
//                 _showBookDialog(context, index);
//               },
//               child: Column(
//                 children: [
//                   Container(
//                     width: 120,
//                     height: 180,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[850],
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 4,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text('Book ${index + 1}',
//                           style: const TextStyle(color: Colors.white)),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Book Title ${index + 1}',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   Text(
//                     'Author ${index + 1}',
//                     style: const TextStyle(color: Colors.white60),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void Logout(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Logout'),
//           content: const Text('Are you sure you want to log out?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 print('User logged out');
//               },
//               child: const Text('Logout'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showBookDialog(BuildContext context, int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//           child: Container(
//             height: 500,
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Book Title ${index + 1}',
//                           style: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Author ${index + 1}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 16),
//                         const Text(
//                           'Description of the book will go here. You can add more detailed information about the selected book.',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         const SizedBox(height: 16),
//                         const Text(
//                           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         const Text(
//                           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         const Text(
//                           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => FinalprojectReadbook()));
//                       },
//                       child: const Text(
//                         'Read',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(0))),
//                     ),
//                     const SizedBox(width: 8),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: const Text(
//                         'Buy',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(0))),
//                     ),
//                     const SizedBox(width: 8),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: const Text(
//                         'Cancel',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(0))),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
