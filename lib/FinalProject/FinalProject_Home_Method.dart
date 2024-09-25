// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedBookIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       // Wrap the ListView in a SingleChildScrollView
//       child: Column(
//         children: [
//           const SectionTitle(title: 'Continue Reading'),
//           BookList(onBookTap: (index) {
//             setState(() {
//               _selectedBookIndex = index;
//             });
//             _showBookDialog(context, index);
//           }),
//           const SectionTitle(title: 'Top Picks for You'),
//           BookList(onBookTap: (index) {
//             setState(() {
//               _selectedBookIndex = index;
//             });
//             _showBookDialog(context, index);
//           }),
//           const SectionTitle(title: 'Top Books in the Philippines'),
//           BookList(onBookTap: (index) {
//             setState(() {
//               _selectedBookIndex = index;
//             });
//             _showBookDialog(context, index);
//           }),
//         ],
//       ),
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
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Author ${index + 1}',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         const Text(
//                           'Description of the book will go here. You can add more detailed information about the selected book.',
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

// class SectionTitle extends StatelessWidget {
//   final String title;

//   const SectionTitle({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
//       child: Text(
//         title,
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
//   final Function(int) onBookTap; // Callback for book tap

//   const BookList({required this.onBookTap});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () {
//                 onBookTap(index); // Call the callback on tap
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
// }
