import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second_application/Component/Project_AddBookComponent.dart';
import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_SignOut.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Upload.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Download.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Favorite.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Home(1).dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Login.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Upcoming.dart';

class navigation extends StatelessWidget {
  const navigation({
    super.key,
    required this.showAddBoolBTN,
  });

  final bool showAddBoolBTN;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  AppBar AppBarWidget(BuildContext context) {
    return AppBar(
      title: const Text(
        'Incredi-Book',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
      ),
      iconTheme: const IconThemeData(color: Colors.red),
      centerTitle: true,
      backgroundColor: Colors.black,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: [
        if (showAddBoolBTN)
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ProjectAddbookcomponent();
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
      ],
    );
  }

  Widget drawerWidget(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser?.uid)
                .get(),
            builder: (context, snapshot) {
              String userName = 'Loading...';
              String userProfile = '';
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  userName = snapshot.data!['name'] ?? 'No Name';
                  // userProfile = snapshot.data!['profileUrl'] ?? 'No image';
                } else {
                  userName = 'User not found';
                }
              }

              return DrawerHeader(
                decoration: const BoxDecoration(color: Colors.black),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://png.pngtree.com/png-clipart/20230913/original/pngtree-profile-picture-png-image_11063391.png'),
                          backgroundColor: Colors.white,
                        ),
                        Positioned(
                          bottom: -8,
                          right: -8,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.camera_alt,
                              size: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userName,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ],
                ),
              );
            },
          ),
          _buildDrawerItem(context, Icons.home, 'Home', const MainPage()),
          _buildDrawerItem(context, Icons.download, 'Downloads',
              const FinalprojectDownload()),
          _buildDrawerItem(context, Icons.upload_file, 'Uploads',
              const FinalprojectUpload()),
          _buildDrawerItem(context, Icons.favorite, 'Favorites',
              const FinalprojectFavorite()),
          _buildDrawerItem(context, Icons.event_note, 'Upcoming',
              const FinalprojectUpcoming()),
          const SizedBox(height: 250),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log Out', style: TextStyle(color: Colors.white)),
            onTap: () async {
              if (currentUser != null) {
                print("Signed out User ID: ${currentUser.uid}");
              } else {
                print("No user is currently signed in.");
              }
              await SignOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const FinalprojectLogin()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(
      BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => page));
      },
    );
  }

  void showAddBook(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 800,
            height: 600,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Book',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                Container(
                  child: Image(image: NetworkImage('')),
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Select Book Cover')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Add',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
