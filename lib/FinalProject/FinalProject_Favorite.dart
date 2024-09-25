import 'package:flutter/material.dart';
import 'package:second_application/FinalProject/FinalProject_UI_Methods.dart';

class FinalprojectFavorite extends StatefulWidget {
  const FinalprojectFavorite({super.key});

  @override
  State<FinalprojectFavorite> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FinalprojectFavorite> {
  final List<Map<String, String>> cartItems = [
    {
      "title": "Love Next Door",
      "details": "7 Episodes | 5.1 GB",
      "image": "pavola.jpg",
    },
    {
      "title": "How to Make Millions Before",
      "details": "1.1 GB",
      "image": "image.jpg",
    },
  ];

  late List<bool> _checkedStates;

  @override
  void initState() {
    super.initState();
    _checkedStates = List.generate(cartItems.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: customDrawer(context),
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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var item = cartItems[index];
                  return buildDownloadGridItem(
                    item['title']!,
                    item['details']!,
                    item['image']!,
                    index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDownloadGridItem(
      String title, String details, String imageUrl, int index) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              child: Center(
                child: Image.asset(
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
                Icon(Icons.favorite),
                TextButton(
                  onPressed: () {
                    print('Read $title');
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
}
