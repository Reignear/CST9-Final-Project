import 'package:flutter/material.dart';
import 'package:second_application/FinalProject/FinalProject_Home.dart';
import 'package:second_application/FinalProject/FinalProject_UI_Methods.dart';

class FinalprojectCart extends StatefulWidget {
  const FinalprojectCart({super.key});

  @override
  State<FinalprojectCart> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FinalprojectCart> {
  final List<Map<String, String>> cartItems = [
    {
      "title": "Love Next Door",
      "details": "7 Episodes | 5.1 GB",
      "image": "pavola.jpg",
    },
    {
      "title": "How to Make Millions Before",
      "details": "1.1 GB",
      "image": "image.jpg",
    },
    {
      "title": "Love Next Door",
      "details": "7 Episodes | 5.1 GB",
      "image": "pavola.jpg",
    },
    {
      "title": "How to Make Millions Before",
      "details": "1.1 GB",
      "image": "image.jpg",
    },
    {
      "title": "Love Next Door",
      "details": "7 Episodes | 5.1 GB",
      "image": "pavola.jpg",
    },
    {
      "title": "How to Make Millions Before",
      "details": "1.1 GB",
      "image": "image.jpg",
    },
    {
      "title": "Love Next Door",
      "details": "7 Episodes | 5.1 GB",
      "image": "pavola.jpg",
    },
    {
      "title": "How to Make Millions Before",
      "details": "1.1 GB",
      "image": "image.jpg",
    },
    {
      "title": "Love Next Door",
      "details": "7 Episodes | 5.1 GB",
      "image": "pavola.jpg",
    },
    {
      "title": "How to Make Millions Before",
      "details": "1.1 GB",
      "image": "image.jpg",
    },
    {
      "title": "Love Next Door",
      "details": "7 Episodes | 5.1 GB",
      "image": "pavola.jpg",
    },
    {
      "title": "How to Make Millions Before",
      "details": "1.1 GB",
      "image": "image.jpg",
    },
  ];

  // Track the checked state of each item
  late List<bool> _checkedStates;

  @override
  void initState() {
    super.initState();
    _checkedStates = List.generate(cartItems.length, (index) => false);
  }

  // int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: customDrawer(context),
      bottomNavigationBar: BottomNavBar(context),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Cart",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...cartItems.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;
            return buildDownloadItem(
                item['title']!, item['details']!, item['image']!, index);
          }).toList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildDownloadItem(
      String title, String details, String imageUrl, int index) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: _checkedStates[index],
            onChanged: (bool? value) {
              setState(() {
                _checkedStates[index] = value ?? false;
              });
            },
            activeColor: Colors.red,
          ),
          SizedBox(
            width: 80,
            height: 50,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey,
                  child: const Icon(Icons.error, color: Colors.white),
                );
              },
            ),
          ),
        ],
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      subtitle: Text(
        details,
        style: TextStyle(color: Colors.white70, fontSize: 12),
      ),
      trailing: TextButton(
          onPressed: () {
            print('Deleting $title');
          },
          child: Icon(
            Icons.delete,
            color: Colors.red,
          )),
    );
  }

  Widget BottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(color: Colors.red, fontSize: 14),
      unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 12),

      // currentIndex: widget.currentIndex,
      // onTap: widget.onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_bag,
          ),
          label: 'Check out',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.cancel,
          ),
          label: 'Cancel',
        ),
      ],
    );
  }
}
