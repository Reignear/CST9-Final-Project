import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:second_application/Component/Project_DesignComponent.dart';
import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_FireStoreService.dart';
import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_SignOut.dart';
import 'package:second_application/FinalProject/FinalProject_FireBaseModel.dart/FinalProject_BookModel.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Upload.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Download.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Favorite.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Login.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_ReadBook.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Upcoming.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPage> {
  late String UrlImage;
  Future<String> fetchImageUrl(String storagePath) async {
    try {
      String imageUrl =
          await FirebaseStorage.instance.ref(storagePath).getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error fetching image: $e");
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigation(
        showAddBoolBTN: true,
      ).AppBarWidget(context),
      drawer: navigation(
        showAddBoolBTN: true,
      ).drawerWidget(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.black,
      child: StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().getBookDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No books available'));
          }

          final books = snapshot.data!.docs;
          return ListView(
            children: [
              _buildSection('Books'),
              _buildBookGrid(books),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBookGrid(List<QueryDocumentSnapshot> books) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.6,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return _buildBookItem(context, books[index]);
      },
    );
  }

  Widget _buildBookItem(BuildContext context, QueryDocumentSnapshot bookDoc) {
    final bookData = bookDoc.data() as Map<String, dynamic>;

    final String imageUrl = bookData['imageUrl'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _showBookDialog(context, bookData);
        },
        child: Column(
          children: [
            _buildBookCover(imageUrl),
            _buildBookTitle(bookData['bookTitle']),
            _buildBookAuthor(bookData['bookAuthor']),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCover(String imageUrl) {
    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text('Failed to load image',
                  style: TextStyle(color: Colors.red)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBookTitle(String title) {
    return Text(
      title,
      style: const TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBookAuthor(String author) {
    return Text(
      author,
      style: const TextStyle(color: Colors.white60),
      textAlign: TextAlign.center,
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
                        // Image.network(''),
                        Center(
                          child: Text(
                            bookData['bookTitle'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            bookData['bookAuthor'],
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            bookData['bookDescription'],
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 5),
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FinalprojectReadbook(
                            bookTitle: bookData['bookTitle'],
                            bookAuthor: bookData['bookAuthor'],
                            bookStory: bookData['bookStory'],
                          ),
                        ));
                      },
                      child: SizedBox(
                        width: 70,
                        child: Text(
                          'Read',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        width: 70,
                        child: const Text(
                          'Download',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        width: 70,
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
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
