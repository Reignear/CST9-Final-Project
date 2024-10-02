import 'package:flutter/material.dart';
import 'package:second_application/Component/Project_DesignComponent.dart';
import 'package:second_application/FinalProject/useless/FinalProject_UI_Methods.dart';

class FinalprojectUpcoming extends StatefulWidget {
  const FinalprojectUpcoming({super.key});

  @override
  State<FinalprojectUpcoming> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FinalprojectUpcoming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: navigation(showAddBoolBTN: false).AppBarWidget(context),
      drawer: navigation(showAddBoolBTN: false).drawerWidget(context),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/image.jpg',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Blue Box',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'New Episode Coming October 3',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Badminton player Taiki has always admired basketball star Chinatsu from afar. But one spring day, a surprising turn brings them unexpectedly close.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            color: Colors.white54,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/pavola.jpg',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                const Text(
                  'The Boy and The Heron',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Now Streaming',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            color: Colors.white54,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/pavola.jpg',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                const Text(
                  'The Boy and The Heron',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Now Streaming',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
