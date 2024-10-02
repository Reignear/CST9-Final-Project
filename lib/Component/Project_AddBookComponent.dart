import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProjectAddbookcomponent extends StatefulWidget {
  const ProjectAddbookcomponent({super.key});

  @override
  State<ProjectAddbookcomponent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProjectAddbookcomponent> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();

  PlatformFile? pickedFile;
  Uint8List? imageBytes;

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _storyController.dispose();
    super.dispose();
  }

  String generateBookId() {
    var uuid = Uuid();
    return 'book-${uuid.v4().substring(0, 8)}';
  }

  Future<void> uploadFile() async {
    if (pickedFile == null) return;
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('User not logged in');
      return;
    }
    String filePath = 'images/${user.uid}/${pickedFile!.name}';
    Reference storageRef = FirebaseStorage.instance.ref().child(filePath);

    try {
      await storageRef.putData(imageBytes!);
      print("Image Upload successful");

      String downloadURL = await storageRef.getDownloadURL();
      Map<String, dynamic> data = {
        'userId': user.uid,
        'bookTitle': _titleController.text,
        'bookAuthor': _authorController.text,
        'bookDescription': _descriptionController.text,
        'bookStory': _storyController.text,
        'bookID': generateBookId(),
        'filePath': filePath,
        'imageUrl': downloadURL,
      };
      await FirebaseFirestore.instance.collection('books').add(data);
      print("Data Upload successful");

      setState(() {
        Navigator.of(context).pop();
      });
    } catch (e) {
      print("Error occurred while uploading data: $e");
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
      imageBytes = pickedFile!.bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 800,
        height: 700,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Add Book',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              height: 120,
              width: 90,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: imageBytes != null
                      ? Image.memory(
                          imageBytes!,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Image(
                            image: AssetImage('defaultimage.png'),
                          ),
                        ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                selectFile();
              },
              icon: Icon(
                Icons.camera_alt,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Book Title'),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
            const SizedBox(height: 16),
            Container(
              height: 70,
              child: SingleChildScrollView(
                child: TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: "Description of the story...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 150,
              child: SingleChildScrollView(
                child: TextField(
                  controller: _storyController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: "Start typing your story here...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: uploadFile,
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
