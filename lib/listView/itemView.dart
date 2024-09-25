import 'package:flutter/material.dart';
import 'package:second_application/listView/item.dart';
import 'package:second_application/listView/itemList.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({super.key});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  Itemlist items = Itemlist();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  int? editingIndex;

  void showInputDialog(BuildContext context, {int? index}) {
    if (index != null) {
      final item = items.itemList[index];
      nameController.text = item.fullname;
      locationController.text = item.location;
    } else {
      nameController.clear();
      locationController.clear();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(index == null ? 'Enter Details' : 'Edit Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (index == null) {
                    items.itemList.add(Items(
                      fullname: nameController.text,
                      location: locationController.text,
                      picture: 'assets/1.png',
                      age: 19,
                      gender: 'female',
                    ));
                  } else {
                    items.itemList[index] = Items(
                      fullname: nameController.text,
                      location: locationController.text,
                      picture: items.itemList[index].picture,
                      age: items.itemList[index].age,
                      gender: items.itemList[index].gender,
                    );
                  }
                });

                nameController.clear();
                locationController.clear();

                Navigator.of(context).pop();
              },
              child: Text(index == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index) {
    setState(() {
      items.itemList.removeAt(index);
    });
  }

  Widget gridTile(Items item, int index) => Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipOval(
              child: Image.asset(
                item.picture,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
           const SizedBox(height: 10),
            Text('Name: ${item.fullname}'),
            Text('Location: ${item.location}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () {
                    showInputDialog(context, index: index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteItem(index);
                  },
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 80, 223, 255),
        title: const Text('List of Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showInputDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 80, 223, 255),
              Color.fromARGB(255, 12, 2, 29)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.itemList.length,
          itemBuilder: (context, index) {
            return gridTile(items.itemList[index], index);
          },
        ),
      ),
    );
  }
}
