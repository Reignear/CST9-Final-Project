// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_CRUD.dart';
// import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_SignOut.dart';
// import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Cart.dart';
// import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Download.dart';
// import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Favorite.dart';
// import 'package:second_application/FinalProject/FinalProject_FireBaseModel.dart/FinalProject_BookModel.dart';
// import 'package:second_application/FinalProject/FinalProject_FireBaseModel.dart/FinalProject_ImagePicker.dart';
// import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Home(1).dart';
// import 'package:second_application/FinalProject/FinalProject_Home.dart';
// import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Login.dart';
// import 'package:second_application/FinalProject/FinalProject_Upcoming.dart';
// import 'package:random_string/random_string.dart';

// class FinalprojectUiMethods extends StatefulWidget {
//   const FinalprojectUiMethods({super.key});

//   @override
//   State<FinalprojectUiMethods> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<FinalprojectUiMethods> {
//   File? image;
//   UploadTask? uploadTask;

//   final TextEditingController _imageURL_controller = TextEditingController();
//   final TextEditingController _title_controller = TextEditingController();
//   final TextEditingController _author_controller = TextEditingController();
//   final TextEditingController _story_controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: const FinalprojectHome2(),
//     );
//   }

//   AppBar HomeAppBar(BuildContext context) {
//     return AppBar(
//       title: const Text(
//         'Incredi-Book',
//         style: TextStyle(
//           color: Colors.red,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
//       iconTheme: const IconThemeData(color: Colors.red),
//       centerTitle: true,
//       backgroundColor: Colors.black,
//       leading: Builder(
//         builder: (context) {
//           return IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {
//               // Scaffold.of(context).openDrawer();
//             },
//           );
//         },
//       ),
//       actions: [
//         IconButton(
//             onPressed: () {
//               // _showAddBook(context);
//             },
//             icon: const Icon(
//               Icons.add,
//             ))
//       ],
//     );
//   }

// //Appbar Method
//   AppBar customAppBar(BuildContext context) {
//     return AppBar(
//       title: const Text(
//         'Incredi-Book',
//         style: TextStyle(
//           color: Colors.red,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
//       iconTheme: const IconThemeData(color: Colors.red),
//       centerTitle: true,
//       backgroundColor: Colors.black,
//       leading: Builder(
//         builder: (context) {
//           return IconButton(
//             icon: const Icon(
//               Icons.menu,
//               color: Colors.red,
//             ),
//             onPressed: () {
//               // Scaffold.of(context).openDrawer();
//             },
//           );
//         },
//       ),
//     );
//   }

//   Uint8List? _image;
//   void selectImage() async {
//     Uint8List img = await pickImage(ImageSource.gallery);
//     setState(() {
//       _image = img;
//     });
//   }

//   void showAddBook(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: Container(
//             width: 800,
//             height: 600,
//             padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Add Book',
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red),
//                 ),
//                 const SizedBox(height: 20),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Align(
//                       alignment: Alignment.center,
//                       child: Stack(
//                         children: [
//                           InkWell(
//                             child: Container(
//                               height: 120,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: Colors.black,
//                                       style: BorderStyle.solid)),
//                             ),
//                           ),
//                           Positioned(
//                               bottom: 2,
//                               right: 2,
//                               child: InkWell(
//                                 onTap: () async {
//                                   final picture = await ImagePicker()
//                                       .pickImage(source: ImageSource.gallery);

//                                   if (picture != null) {}
//                                 },
//                                 child: Icon(Icons.camera_alt),
//                               ))
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: TextField(
//                             controller: _title_controller,
//                             decoration: const InputDecoration(
//                               hintText: "Book's title here",
//                               labelText: "Book's title here",
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: TextField(
//                             controller: _author_controller,
//                             decoration: const InputDecoration(
//                               hintText: "Author's name here",
//                               labelText: "Author's name here",
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     const SizedBox(height: 10),
//                     Container(
//                       height: 200,
//                       child: TextField(
//                         controller: _story_controller,
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                         decoration: const InputDecoration(
//                           hintText: "Start typing your story here...",
//                           labelText: "Start typing your story here...",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () async {
//                         String Id = randomAlphaNumeric(10);
//                         Book newBook = Book(
//                           bookId: Id,
//                           bookUrl: _imageURL_controller.text,
//                           bookTitle: _title_controller.text,
//                           bookAuthor: _author_controller.text,
//                           bookStory: _story_controller.text,
//                         );

//                         // Add the book to Firestore
//                         await FirebaseFirestore.instance
//                             .collection('books')
//                             .add(newBook.toMap());

//                         // Clear the fields after adding the book
//                         _imageURL_controller.clear();
//                         _title_controller.clear();
//                         _author_controller.clear();
//                         _story_controller.clear();

//                         // Optionally, show a success message
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Book added successfully!')),
//                         );

//                         // Close the dialog
//                         Navigator.of(context).pop();
//                       },
//                       child: const Text(
//                         'Add',
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
//                         'Close',
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

// //Drawer Method
//   Drawer customDrawer(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.black,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.black,
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage: AssetImage('assets/Bugnaw.gif'),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Name here',
//                       style: TextStyle(color: Colors.red),
//                     )
//                   ],
//                 ),
//               )),
//           ListTile(
//             leading: const Icon(
//               Icons.home,
//               color: Colors.red,
//             ),
//             title: const Text(
//               'Home',
//               style: TextStyle(color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const FinalprojectHome2()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.download,
//               color: Colors.red,
//             ),
//             title: const Text(
//               'Downloads',
//               style: TextStyle(color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const FinalprojectDownload()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.shopping_bag,
//               color: Colors.red,
//             ),
//             title: const Text(
//               'Carts',
//               style: TextStyle(color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const FinalprojectCart()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.favorite,
//               color: Colors.red,
//             ),
//             title: const Text(
//               'Favorites',
//               style: TextStyle(color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const FinalprojectFavorite()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.event_note,
//               color: Colors.red,
//             ),
//             title: const Text(
//               'Upcoming',
//               style: TextStyle(color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const FinalprojectUpcoming()));
//             },
//           ),
//           SizedBox(
//             height: 250,
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.logout,
//               color: Colors.red,
//             ),
//             title: const Text(
//               'Log Out',
//               style: TextStyle(color: Colors.white),
//             ),
//             onTap: () async {
//               await SignOut();
//               Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(
//                       builder: (context) => const FinalprojectLogin()),
//                   (route) => false);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
