import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:second_application/Component/Project_DesignComponent.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_ReadBook.dart';

class FinalprojectDownload extends StatefulWidget {
  const FinalprojectDownload({super.key});

  @override
  State<FinalprojectDownload> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FinalprojectDownload> {
  final CollectionReference _booksCollection =
      FirebaseFirestore.instance.collection('downloads');

  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigation(showAddBoolBTN: false).AppBarWidget(context),
      drawer: navigation(showAddBoolBTN: false).drawerWidget(context),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Download",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _booksCollection
                    .where('download_userId', isEqualTo: userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final downloadbooks = snapshot.data?.docs;
                  if (downloadbooks == null || downloadbooks.isEmpty) {
                    return const Center(
                        child: Text(
                      'No books available.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ));
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: downloadbooks.length,
                    itemBuilder: (context, index) {
                      var item =
                          downloadbooks[index].data() as Map<String, dynamic>;
                      var docId = downloadbooks[index].id;

                      return buildDownloadGridItem(
                        title: item['download_bookTitle'] ?? 'No Title',
                        details: item['download_bookAuthor'] ?? 'No Details',
                        story: item['download_bookStory'] ?? 'No Story',
                        imageUrl:
                            item['download_imageUrl'] ?? 'default_image.jpg',
                        docId: docId,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDownloadGridItem({
    required String title,
    required String details,
    required String imageUrl,
    required String docId,
    required String story,
  }) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    width: double.infinity,
                    child: const Icon(Icons.error, color: Colors.white),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              details,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FinalprojectReadbook(
                              bookTitle: title,
                              bookAuthor: details,
                              bookStory: story,
                              bookUrl: imageUrl,
                            )));
                  },
                  child: const Text(
                    'Read',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    bool? confirm =
                        await _showConfirmationDialog(context, title);
                    if (confirm == true) {
                      await FirebaseFirestore.instance
                          .collection('downloads')
                          .doc(docId)
                          .delete();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              'Removed from Downloads',
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context, String title) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete Confirmation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text('Do you want to delete "$title" from downloads?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
