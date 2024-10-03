import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_application/CRUD/auth%20(1).dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController agecontroller = new TextEditingController();
  TextEditingController locationcontroller = new TextEditingController();
  TextEditingController imageUrlController = new TextEditingController();

  File? _selectedImage;

  Stream? EmployeeStream;

  Getontheload() async {
    EmployeeStream = await AuthService().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    Getontheload();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
        stream: EmployeeStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ds["imageUrl"] != null
                                    ? Image.network(
                                        ds["imageUrl"],
                                        height: 80,
                                        width: 80,
                                      )
                                    : Container(),
                                Text(
                                  "Name: " + ds["Name"],
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 20),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    namecontroller.text = ds["Name"];
                                    agecontroller.text = ds["age"];
                                    locationcontroller.text = ds["location"];
                                    imageUrlController.text = ds["imageUrl"];

                                    EditEmployeeDetail(ds["id"]);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.yellow,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      await AuthService()
                                          .deleteEmployeeDetail(ds['id']);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                            Text(
                              "Age: " + ds["age"],
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            ),
                            Text(
                              "Location: " + ds["location"],
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Records'),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30.0,
        ),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }

  Future<void> EditEmployeeDetail(String id) => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Container(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Adjust the size to fit the content
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel)),
                        const SizedBox(width: 8.0),
                        const Text(
                          "Edit Details",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    // Display the current image or a placeholder
                    _selectedImage == null && imageUrlController.text.isNotEmpty
                        ? Image.network(
                            imageUrlController
                                .text, // Display the current imageUrl
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: 100,
                                width: 100), // Placeholder when no image

                    ElevatedButton.icon(
                      icon: const Icon(Icons.image),
                      label: const Text("Select Image"),
                      onPressed: () async {
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (pickedFile != null) {
                          setState(() {
                            _selectedImage = File(pickedFile.path);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      "Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: namecontroller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Text(
                      "Age",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: agecontroller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Text(
                      "Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: locationcontroller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          // Upload the new image if one is selected
                          String? imageUrl;
                          if (_selectedImage != null) {
                            imageUrl = await AuthService()
                                .uploadImage(_selectedImage!, id);
                          }

                          // Update employee details with the new information
                          Map<String, dynamic> updateInfo = {
                            "Name": namecontroller.text,
                            "age": agecontroller.text,
                            "id": id,
                            "location": locationcontroller.text,
                          };

                          if (imageUrl != null) {
                            updateInfo['imageUrl'] = imageUrl;
                          }

                          await AuthService()
                              .updateEmployeeDetail(id, updateInfo)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: Text("Update"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}
