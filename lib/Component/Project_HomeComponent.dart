// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_FireStoreService.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_ReadBook.dart';

class ProjectHomeComponent extends StatefulWidget {
  const ProjectHomeComponent({super.key});

  @override
  State<ProjectHomeComponent> createState() => _ProjectHomeComponentState();
}

class _ProjectHomeComponentState extends State<ProjectHomeComponent> {
  Stream<QuerySnapshot>? bookStream;

  TextEditingController _searchfield_controller = TextEditingController();
  String searchQuery = "";

  Future<void> fetchBooks() async {
    bookStream = await DatabaseService().getBookDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  @override
  void dispose() {
    _searchfield_controller.dispose();
    super.dispose();
  }

  Widget displayBooks() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 350.0,
            child: Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: _searchfield_controller,
                decoration: InputDecoration(
                  labelText: 'Search Books',
                  suffixIcon: Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: bookStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No books found'));
              }

              var filteredBooks = snapshot.data!.docs.where((book) {
                var title = (book['bookTitle'] as String).toLowerCase();
                var author = (book['bookAuthor'] as String).toLowerCase();
                return title.contains(searchQuery.toLowerCase()) ||
                    author.contains(searchQuery.toLowerCase());
              }).toList();

              if (filteredBooks.isEmpty) {
                return Center(
                    child: Text(
                  'No books match your search',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ));
              }

              return GridView.builder(
                padding: EdgeInsets.all(15),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.575,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnap = filteredBooks[index];
                  return GestureDetector(
                    onTap: () {
                      _showBookDialog(
                          context, documentSnap.data() as Map<String, dynamic>);
                    },
                    child: Material(
                      color: Colors.transparent,
                      elevation: 4.0,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                            child: Container(
                              height: 180,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                image: DecorationImage(
                                  image: NetworkImage(documentSnap['imageUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            documentSnap['bookTitle'],
                            style: GoogleFonts.gowunBatang(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            documentSnap['bookAuthor'],
                            style: GoogleFonts.gowunBatang(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showBookDialog(BuildContext context, Map<String, dynamic> bookData) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final favoritesStream = FirebaseFirestore.instance
          .collection('favorites')
          .where('fav_userId', isEqualTo: user.uid)
          .where('fav_bookID', isEqualTo: bookData['bookID'])
          .snapshots();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder<QuerySnapshot>(
            stream: favoritesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              bool isFavorite =
                  snapshot.hasData && snapshot.data!.docs.isNotEmpty;

              return _showDialog(context, bookData, isFavorite);
            },
          );
        },
      );
    } else {
      _showDialog(context, bookData, false);
    }
  }

  Widget _showDialog(
      BuildContext context, Map<String, dynamic> bookData, bool isFavorite) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        height: 500,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () async {
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  String userId = user.uid;

                  try {
                    if (!isFavorite) {
                      await FirebaseFirestore.instance
                          .collection('favorites')
                          .add({
                        'fav_userId': userId,
                        'fav_bookID': bookData['bookID'],
                        'fav_bookTitle': bookData['bookTitle'],
                        'fav_bookAuthor': bookData['bookAuthor'],
                        'fav_bookDescription': bookData['bookDescription'],
                        'fav_bookStory': bookData['bookStory'],
                        'fav_filePath': bookData['filePath'],
                        'fav_imageUrl': bookData['imageUrl'],
                        'fav_bookUploader': bookData['userId'],
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Center(child: Text('Added to Favorites'))),
                      );
                    } else {
                      QuerySnapshot querySnapshot = await FirebaseFirestore
                          .instance
                          .collection('favorites')
                          .where('fav_userId', isEqualTo: userId)
                          .where('fav_bookID', isEqualTo: bookData['bookID'])
                          .get();

                      for (var doc in querySnapshot.docs) {
                        await doc.reference.delete();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Center(child: Text('Removed from Favorites'))),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Center(
                              child: Text('Failed to toggle favorite: $e'))),
                    );
                  }
                }
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Container(
                          width: 130,
                          height: 180,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Image.network(
                            bookData['imageUrl'],
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        bookData['bookTitle'],
                        style: GoogleFonts.gowunBatang(
                            fontWeight: FontWeight.normal,
                            fontSize: 22,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        bookData['bookAuthor'],
                        style: GoogleFonts.gowunBatang(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        bookData['bookDescription'],
                        style: GoogleFonts.gowunBatang(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FinalprojectReadbook(
                              bookTitle: bookData['bookTitle'],
                              bookAuthor: bookData['bookAuthor'],
                              bookStory: bookData['bookStory'],
                              bookUrl: bookData['imageUrl'],
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Read',
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          String userId = user.uid;
                          try {
                            var querySnapshot = await FirebaseFirestore.instance
                                .collection('downloads')
                                .where('download_userId', isEqualTo: userId)
                                .where('download_bookID',
                                    isEqualTo: bookData['bookID'])
                                .get();

                            if (querySnapshot.docs.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Center(
                                        child: Text(
                                            'This book is already downloaded'))),
                              );
                            } else {
                              await FirebaseFirestore.instance
                                  .collection('downloads')
                                  .add({
                                'download_userId': userId,
                                'download_bookID': bookData['bookID'],
                                'download_bookTitle': bookData['bookTitle'],
                                'download_bookAuthor': bookData['bookAuthor'],
                                'download_bookDescription':
                                    bookData['bookDescription'],
                                'download_bookStory': bookData['bookStory'],
                                'download_filePath': bookData['filePath'],
                                'download_imageUrl': bookData['imageUrl'],
                                'download_bookUploader': bookData['userId'],
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Center(
                                        child: Text('Added to Downloads'))),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Center(
                                      child: Text(
                                          'Failed to toggle donwloads: $e'))),
                            );
                          }
                        }
                      },
                      child: const Text('Download',
                          style: TextStyle(fontSize: 13, color: Colors.white)),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: displayBooks(),
    );
  }
}
