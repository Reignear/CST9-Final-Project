import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second_application/Component/Project_DesignComponent.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_ReadBook.dart';

class FinalprojectFavorite extends StatefulWidget {
  const FinalprojectFavorite({super.key});

  @override
  State<FinalprojectFavorite> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FinalprojectFavorite> {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
  }

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
              "Favorite",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('favorites')
                    .where('fav_userId', isEqualTo: userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No favorites found.'));
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      return buildDownloadGridItem(
                        doc['fav_bookTitle'] ?? 'No title',
                        doc['fav_bookAuthor'] ?? 'No Details',
                        doc['fav_imageUrl'] ?? 'No image',
                        doc['fav_bookStory'] ?? 'No story',
                        doc['fav_imageUrl'] ?? 'No URL',
                        doc.id,
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

  Widget buildDownloadGridItem(String title, String details, String imageUrl,
      String story, String url, String docId) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
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
                GestureDetector(
                  onTap: () async {
                    bool? confirm =
                        await _showConfirmationDialog(context, title);
                    if (confirm == true) {
                      await FirebaseFirestore.instance
                          .collection('favorites')
                          .doc(docId)
                          .delete();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Center(
                                child: Text(
                          'Removed from Favorites',
                        ))),
                      );
                    }
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FinalprojectReadbook(
                              bookTitle: title,
                              bookAuthor: details,
                              bookStory: story,
                              bookUrl: url,
                            )));
                  },
                  child: const Text(
                    'Read',
                    style: TextStyle(color: Colors.blue),
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
            'Remove Confirmation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text('Do you want to remove "$title" from favorites?'),
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
