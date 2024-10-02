// import 'package:flutter/material.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   String name = 'Sarah Abs';
//   String email = 'sarah.abs@gmail.com';
//   double ranking = 4.8;
//   int following = 35;
//   int followers = 50;
//   String about =
//       'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers’ goals in a smooth way.';

//   Widget _buildStatCard(String title, String value, BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: <Widget>[
//           // Profile Image and Name
//           Row(
//             children: <Widget>[
//               const CircleAvatar(
//                 radius: 40,
//                 backgroundImage: NetworkImage(
//                   'https://via.placeholder.com/150', // Replace with actual profile image URL
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     name,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     email,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),

//           // Ranking, Following, and Followers stats
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               _buildStatCard('Ranking', ranking.toString(), context),
//               _buildStatCard('Following', following.toString(), context),
//               _buildStatCard('Followers', followers.toString(), context),
//             ],
//           ),
//           const SizedBox(height: 20),

//           // Upgrade to Pro Button
//           ElevatedButton(
//             onPressed: () {
//               // Example of triggering state change (e.g., upgrading changes ranking)
//               setState(() {
//                 ranking += 0.1; // Simulate an upgrade by increasing ranking
//               });
//             },
//             child: const Text('Upgrade To PRO'),
//           ),
//           const SizedBox(height: 20),

//           // About Section
//           const Text(
//             'About',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             about,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
