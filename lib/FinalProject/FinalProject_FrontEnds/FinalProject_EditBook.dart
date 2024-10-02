import 'package:flutter/material.dart';
import 'package:second_application/Component/Project_DesignComponent.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FinalprojectEditbook extends StatefulWidget {
  final String documentId;
  final String editTitle;
  final String editAuthor;
  final String editDescription;
  final String editStory;

  const FinalprojectEditbook({
    Key? key,
    required this.documentId,
    required this.editTitle,
    required this.editAuthor,
    required this.editDescription,
    required this.editStory,
  }) : super(key: key);

  @override
  State<FinalprojectEditbook> createState() => _FinalprojectEditbookState();
}

class _FinalprojectEditbookState extends State<FinalprojectEditbook> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _descriptionController;
  late TextEditingController _storyController;

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

  void _updateBook() async {
    String updatedTitle = _titleController.text.trim();
    String updatedAuthor = _authorController.text.trim();
    String updatedDescription = _descriptionController.text.trim();
    String updatedStory = _storyController.text.trim();

    setState(() {
      // Navigator.pop(context, {
      //   'bookTitle': updatedTitle,
      //   'bookAuthor': updatedAuthor,
      //   'bookDescription': updatedDescription,
      //   'bookStory': updatedStory,
      // });
    });
    if (updatedTitle.isEmpty ||
        updatedAuthor.isEmpty ||
        updatedDescription.isEmpty ||
        updatedStory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('books')
          .doc(widget.documentId)
          .update({
        'bookTitle': updatedTitle,
        'bookAuthor': updatedAuthor,
        'bookDescription': updatedDescription,
        'bookStory': updatedStory,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book updated successfully.')),
      );

      Navigator.pop(context);
    } catch (e) {
      print('Error updating book: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating book: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigation(showAddBoolBTN: false).AppBarWidget(context),
      drawer: navigation(showAddBoolBTN: false).drawerWidget(context),
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
          ),
          IconButton(
            onPressed: () {},
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
                  onPressed: _updateBook,
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
                    Navigator.pop(context); // Go back to the previous screen
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
