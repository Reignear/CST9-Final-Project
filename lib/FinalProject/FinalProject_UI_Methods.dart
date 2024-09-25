import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_SignOut.dart';
import 'package:second_application/FinalProject/FinalProject_Cart.dart';
import 'package:second_application/FinalProject/FinalProject_Download.dart';
import 'package:second_application/FinalProject/FinalProject_Favorite.dart';
import 'package:second_application/FinalProject/FinalProject_Home.dart';
import 'package:second_application/FinalProject/FinalProject_Login.dart';
import 'package:second_application/FinalProject/FinalProject_Upcoming.dart';

class FinalprojectUiMethods extends StatefulWidget {
  const FinalprojectUiMethods({super.key});

  @override
  State<FinalprojectUiMethods> createState() => _MyWidgetState();
}

//Appbar Method
AppBar customAppBar(BuildContext context) {
  return AppBar(
    title: const Text(
      'Incredi-Book',
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.w800,
      ),
    ),
    // flexibleSpace: Container(
    //   decoration: const BoxDecoration(
    //       image: DecorationImage(
    //           image: AssetImage('assets/library.jpg'), fit: BoxFit.cover)),
    // ),
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
  );
}

//Drawer Method
Drawer customDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.black,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/Bugnaw.gif'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Name here',
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            )),
        ListTile(
          leading: const Icon(
            Icons.home,
            color: Colors.red,
          ),
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FinalProjectHome()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.download,
            color: Colors.red,
          ),
          title: const Text(
            'Downloads',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FinalprojectDownload()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.shopping_bag,
            color: Colors.red,
          ),
          title: const Text(
            'Carts',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FinalprojectCart()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          title: const Text(
            'Favorites',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FinalprojectFavorite()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.bookmark,
            color: Colors.red,
          ),
          title: const Text(
            'Bookmark',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.upcoming,
            color: Colors.red,
          ),
          title: const Text(
            'Upcoming',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FinalprojectUpcoming()));
          },
        ),
        const SizedBox(
          height: 130,
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            logoutConfirmationDialog(context);
          },
        ),
      ],
    ),
  );
}

void logoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              SignOut();
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const FinalprojectLogin()),
              );
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

class _MyWidgetState extends State<FinalprojectUiMethods> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
