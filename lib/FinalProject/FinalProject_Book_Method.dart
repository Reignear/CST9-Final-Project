
// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';

// class FinalprojectBookMethod extends StatefulWidget {
//   const FinalprojectBookMethod({super.key});

//   @override
//   State<FinalprojectBookMethod> createState() => _MyWidgetState();
// }

// //booklist method
// Widget BookList(BuildContext context) {
//   return Container(
//     height: 250,
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: 10,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GestureDetector(
//             onTap: () {
//               _showBookDialog(context, index);
//             },
//             child: Column(
//               children: [
//                 Container(
//                   width: 120,
//                   height: 180,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[850],
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text('Book ${index + 1}',
//                         style: const TextStyle(color: Colors.white)),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Book Title ${index + 1}',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Text(
//                   'Author ${index + 1}',
//                   style: TextStyle(color: Colors.white60),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }

// void _showBookDialog(BuildContext context, int index) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Book ${index + 1} Details'),
//         content: Text('Details about Book ${index + 1}'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Close'),
//           ),
//         ],
//       );
//     },
//   );
// }

// class _MyWidgetState extends State<FinalprojectBookMethod> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
