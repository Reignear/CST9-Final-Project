import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalprojectReadbook extends StatelessWidget {
  final String bookTitle;
  final String bookAuthor;
  final String bookStory;
  final String bookUrl;
  FinalprojectReadbook({
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookStory,
    required this.bookUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customReadAppBar(context),
      body: ListView(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 150,
                  height: 200,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Image.network(bookUrl),
                ),
              ),
              Text(
                bookTitle,
                style: GoogleFonts.gowunBatang(
                    fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Text(
                bookAuthor,
                style: GoogleFonts.gowunBatang(
                    fontWeight: FontWeight.w800, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0), // Adjust horizontal padding
                child: Container(
                  alignment: Alignment.topLeft, // Align text to the left
                  child: Text(
                    bookStory,
                    style: GoogleFonts.gowunBatang(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar customReadAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Incredi-Book',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w800,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.red),
      centerTitle: true,
      backgroundColor: Colors.black,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
