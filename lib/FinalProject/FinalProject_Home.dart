import 'package:flutter/material.dart';
import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_SignOut.dart';
import 'package:second_application/FinalProject/FinalProject_Cart.dart';
import 'package:second_application/FinalProject/FinalProject_Favorite.dart';

import 'package:second_application/FinalProject/FinalProject_Login.dart';
import 'package:second_application/FinalProject/FinalProject_UI_Methods.dart';

class FinalProjectHome extends StatefulWidget {
  const FinalProjectHome({super.key});

  @override
  State<FinalProjectHome> createState() => _FinalProjectHomeState();
}

class _FinalProjectHomeState extends State<FinalProjectHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    FinalprojectFavorite(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: customDrawer(context),
      body: _pages[_selectedIndex],

      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.black,
      //   unselectedItemColor: Colors.white60,
      //   selectedItemColor: Colors.red,
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView(
        children: [
          SectionTitle(title: 'Continue Reading'),
          BookList(),
          SectionTitle(title: 'Top Picks for You'),
          BookList(),
          SectionTitle(title: 'Top Books in the Philippines'),
          BookList(),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

void Logout(BuildContext context) {
  // Show the alert dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              // If the user cancels, close the dialog
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // If the user confirms, log out and close the dialog
              // Add your logout logic here
              Navigator.of(context).pop();
              print('User logged out');
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _showBookDialog(context, index);
              },
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text('Book ${index + 1}',
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Book Title ${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Author ${index + 1}',
                    style: TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showBookDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            height: 500,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Book Title ${index + 1}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Author ${index + 1}',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Description of the book will go here. You can add more detailed information about the selected book.',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Read',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0))),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0))),
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
