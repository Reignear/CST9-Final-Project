import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:second_application/Component/Project_DesignComponent.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_EditBook.dart';
import 'package:second_application/FinalProject/useless/FinalProject_Home.dart';
import 'package:second_application/FinalProject/useless/FinalProject_UI_Methods.dart';
import 'package:second_application/FinalProject/useless/FinalProject_AddMethods.dart';

class FinalprojectUpload extends StatefulWidget {
  const FinalprojectUpload({super.key});

  @override
  State<FinalprojectUpload> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FinalprojectUpload> {
  List<Map<String, dynamic>> uploadItems = [];
  bool isLoading = true;

  late List<bool> _checkedStates;

  @override
  void initState() {
    super.initState();

    fetchUserUploadedBooks();
  }

  Future<void> fetchUserUploadedBooks() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("No user is currently logged in.");
      }

      final querySnapshot = await FirebaseFirestore.instance
          .collection('books')
          .where('userId', isEqualTo: user.uid)
          .get();

      final List<Map<String, dynamic>> fetchedBooks =
          querySnapshot.docs.map((doc) {
        return {
          "documentId": doc.id,
          "bookTitle": doc['bookTitle'],
          "bookDescription": doc['bookDescription'],
          "imageUrl": doc['imageUrl'],
          "bookAuthor": doc['bookAuthor'],
          "bookStory": doc['bookStory'],
        };
      }).toList();

      setState(() {
        uploadItems = fetchedBooks;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching user books: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteBook(String documentId, int index) async {
    try {
      String imageUrl = uploadItems[index]['imageUrl'];

      if (imageUrl.isNotEmpty) {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference storageRef = storage.refFromURL(imageUrl);

        await storageRef.delete();
      }

      await FirebaseFirestore.instance
          .collection('books')
          .doc(documentId)
          .delete();

      setState(() {
        uploadItems.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book and image deleted successfully.')),
      );
    } catch (e) {
      print('Error deleting book or image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting book or image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigation(showAddBoolBTN: false).AppBarWidget(context),
      drawer: navigation(showAddBoolBTN: false).drawerWidget(context),
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
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
                    "Uploads",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ...uploadItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;
                  return buildDownloadItem(item['bookTitle']!,
                      item['bookDescription']!, item['imageUrl']!, index);
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
          SizedBox(
            width: 80,
            height: 50,
            child: Image.network(
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
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      subtitle: Text(
        details,
        style: const TextStyle(color: Colors.white70, fontSize: 12),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              final String documentId = uploadItems[index]['documentId'] ??
                  "unknown_id"; // Fallback if null
              final String bookTitle =
                  uploadItems[index]['bookTitle'] ?? "No Title";
              final String bookAuthor =
                  uploadItems[index]['bookAuthor'] ?? "No Author";
              final String bookDescription =
                  uploadItems[index]['bookDescription'] ?? "No Description";
              final String bookStory =
                  uploadItems[index]['bookStory'] ?? "No Story";

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FinalprojectEditbook(
                  documentId: documentId,
                  editTitle: bookTitle,
                  editAuthor: bookAuthor,
                  editDescription: bookDescription,
                  editStory: bookStory,
                ),
              ));
            },
            child: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
          TextButton(
            onPressed: () {
              deleteBook(uploadItems[index]['documentId'], index);
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
