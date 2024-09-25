import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAPI extends StatefulWidget {
  const GetAPI({super.key});

  @override
  State<GetAPI> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<GetAPI> {
  List<dynamic> Books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: Books.length,
          itemBuilder: (context, index) {
            final book = Books[index];
            final title = book['title'];
            return ListTile(
              title: Text(title),
            );
          }),
    );
  }

  void fetchBooks() async {
    const url = 'https://api.nytimes.com/svc/books/v3/lists.json';
    final location = Uri.parse(url);
    final response = await http.get(location);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      Books = json['Results'];
    });
    print("fetchBook Completed");
  }

  void launchURL(String url) {
    // Optionally add URL launcher to navigate to the book URL
    // You can use the url_launcher package for this
    // final Uri launchUri = Uri.parse(url);
    // launch(launchUri.toString());
  }
}
