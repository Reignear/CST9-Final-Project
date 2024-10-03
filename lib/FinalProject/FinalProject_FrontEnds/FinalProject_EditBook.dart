import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FinalprojectEditbook extends StatefulWidget {
  final String documentId;
  final String editTitle;
  final String editAuthor;
  final String editDescription;
  final String editStory;
  final String editImage;

  const FinalprojectEditbook({
    Key? key,
    required this.documentId,
    required this.editTitle,
    required this.editAuthor,
    required this.editDescription,
    required this.editStory,
    required this.editImage,
  }) : super(key: key);

  @override
  State<FinalprojectEditbook> createState() => _FinalprojectEditbookState();
}

class _FinalprojectEditbookState extends State<FinalprojectEditbook> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _descriptionController;
  late TextEditingController _storyController;

  PlatformFile? pickedFile;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.editTitle);
    _authorController = TextEditingController(text: widget.editAuthor);
    _descriptionController =
        TextEditingController(text: widget.editDescription);
    _storyController = TextEditingController(text: widget.editStory);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _storyController.dispose();
    super.dispose();
  }

  Future<void> uploadFile() async {
    // Check if the required fields are filled
    String bookTitle = _titleController.text.trim();
    String bookAuthor = _authorController.text.trim();
    String bookDescription = _descriptionController.text.trim();
    String bookStory = _storyController.text.trim();

    if (bookTitle.isEmpty ||
        bookAuthor.isEmpty ||
        bookDescription.isEmpty ||
        bookStory.isEmpty) {
      print("One or more book fields are empty");
      return;
    }

    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('User not logged in');
      return;
    }

    String filePath = 'images/${user.uid}/${pickedFile!.name}';
    Reference storageRef = FirebaseStorage.instance.ref().child(filePath);

    try {
      // Upload the image bytes to Firebase Storage
      await storageRef.putData(imageBytes!);
      print("Image Upload successful");
      String downloadURL = await storageRef.getDownloadURL();

      // Prepare the data for Firestore
      Map<String, dynamic> data = {
        'userId': user.uid,
        'bookTitle': bookTitle,
        'bookAuthor': bookAuthor,
        'bookDescription': bookDescription,
        'bookStory': bookStory,
        'filePath': filePath,
        'imageUrl': downloadURL,
      };

      // Update the Firestore document
      await FirebaseFirestore.instance
          .collection('books')
          .doc(widget.documentId)
          .update(data);

      print("Data Update successful");
      setState(() {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            'Book updated successfully!',
            textAlign: TextAlign.center,
          )),
        );
      });
    } catch (e) {
      print("Error occurred while uploading data: $e");
    }
  }

  void _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      pickedFile = result.files.first;

      if (pickedFile!.bytes != null) {
        imageBytes = pickedFile!.bytes;
        print("Picked file name: ${pickedFile!.name}");
        print("Image bytes length: ${imageBytes?.length}");
        setState(() {});
      } else if (pickedFile!.path != null) {
        File file = File(pickedFile!.path!);
        try {
          imageBytes = await file.readAsBytes();
          print("Picked file path: ${pickedFile?.path}");
          print("Image bytes length: ${imageBytes?.length}");
          setState(() {});
        } catch (e) {
          print("Error reading image bytes: $e");
        }
      } else {
        print('No valid file selected');
      }
    } else {
      print('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
        actions: [IconButton(onPressed: uploadFile, icon: Icon(Icons.save))],
      ),
      body: _editBookBody(context),
    );
  }

  Widget _editBookBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Edit Book',
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
            child: imageBytes != null
                ? Image.memory(
                    imageBytes!,
                    fit: BoxFit.cover,
                  )
                : Image.network(widget.editImage),
          ),
          IconButton(
            onPressed: _pickImage,
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
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: "Description of the story...",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _storyController,
            maxLines: 4,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: "Start typing your story here...",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
                child: TextButton(
                  onPressed: uploadFile,
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 100,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
