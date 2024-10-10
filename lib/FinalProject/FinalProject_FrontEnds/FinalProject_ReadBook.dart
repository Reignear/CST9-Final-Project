import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalprojectReadbook extends StatefulWidget {
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
  State<FinalprojectReadbook> createState() => _FinalprojectReadbookState();
}

class _FinalprojectReadbookState extends State<FinalprojectReadbook> {
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
                  child: Image.network(widget.bookUrl),
                ),
              ),
              Text(
                widget.bookTitle,
                style: GoogleFonts.gowunBatang(
                    fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.bookAuthor,
                style: GoogleFonts.gowunBatang(
                    fontWeight: FontWeight.w800, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.bookStory,
                    style: GoogleFonts.gowunBatang(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                    onPressed: () async {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        String userId = user.uid;

                        try {
                          // Fetch the book details
                          QuerySnapshot getBookDetails = await FirebaseFirestore
                              .instance
                              .collection('books')
                              .where('bookTitle', isEqualTo: widget.bookTitle)
                              .where('bookAuthor', isEqualTo: widget.bookAuthor)
                              .get();

                          if (getBookDetails.docs.isNotEmpty) {
                            var bookDetails = getBookDetails.docs.first.data()
                                as Map<String, dynamic>;

                            // Check if the book is already marked as finished by the user
                            QuerySnapshot finishedBooks =
                                await FirebaseFirestore.instance
                                    .collection('finished')
                                    .where('finished_userId', isEqualTo: userId)
                                    .where('finished_bookID',
                                        isEqualTo: bookDetails['bookID'])
                                    .get();

                            if (finishedBooks.docs.isEmpty) {
                              // Book is not yet marked as finished, add to "finished"
                              await FirebaseFirestore.instance
                                  .collection('finished')
                                  .add({
                                'finished_userId': userId,
                                'finished_bookID': bookDetails['bookID'],
                                'finished_bookTitle': bookDetails['bookTitle'],
                                'finished_bookAuthor':
                                    bookDetails['bookAuthor'],
                                'finished_bookDescription':
                                    bookDetails['bookDescription'],
                                'finished_bookStory': bookDetails['bookStory'],
                                'finished_filePath': bookDetails['filePath'],
                                'finished_imageUrl': bookDetails['imageUrl'],
                                'finished_bookUploader': bookDetails['userId'],
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                  'Book added to Finished',
                                  textAlign: TextAlign.center,
                                )),
                              );
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                  'Book already marked as Finished',
                                  textAlign: TextAlign.center,
                                )),
                              );
                            }
                          } else {}
                        } catch (e) {
                          print(e);
                        }
                      }
                      setState(() {});
                    },
                    child: Text(
                      'Finish reading',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              SizedBox(
                height: 20,
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
