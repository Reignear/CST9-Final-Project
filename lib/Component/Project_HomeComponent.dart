import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_FireStoreService.dart';
import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_RegistrationAuthentication.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_ReadBook.dart';

class ProjectHomeComponent extends StatefulWidget {
  const ProjectHomeComponent({super.key});

  @override
  State<ProjectHomeComponent> createState() => _ProjectHomeComponentState();
}

class _ProjectHomeComponentState extends State<ProjectHomeComponent> {
  Stream<QuerySnapshot>? bookStream;

  Future<void> fetchBooks() async {
    bookStream = await DatabaseService().getBookDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  // Displaying books in a grid format
  Widget displayBooks() {
    return StreamBuilder<QuerySnapshot>(
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

        return GridView.builder(
          padding: EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.575,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot documentSnap = snapshot.data!.docs[index];
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
    );
  }

  void _showBookDialog(BuildContext context, Map<String, dynamic> bookData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            height: 500,
            width: 400,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                              width: 150,
                              height: 180,
                              child: Image.network(bookData['imageUrl'])),
                        ),
                        Center(
                          child: Text(
                            bookData['bookTitle'],
                            style: GoogleFonts.gowunBatang(
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                            ),
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
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            bookData['bookDescription'],
                            style: GoogleFonts.gowunBatang(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Add download functionality here
                          },
                          child: const Text('Download',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white)),
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
      },
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
