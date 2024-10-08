import 'package:flutter/material.dart';
import 'package:second_application/Component/Project_DesignComponent.dart';

class FinalprojectUpcoming extends StatefulWidget {
  const FinalprojectUpcoming({super.key});

  @override
  State<FinalprojectUpcoming> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FinalprojectUpcoming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: navigation(showAddBoolBTN: false).AppBarWidget(context),
      drawer: navigation(showAddBoolBTN: false).drawerWidget(context),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/pride.jpg',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Pride and Passion',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Clara DeVine',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Clara DeVine’s Pride and Passion is a sweeping romance set in the bustling streets of New York City. Following the lives of two lovers, Alex and Sam, the novel explores their journey through love, heartbreak, and resilience in a society that isn’t always accepting. With the backdrop of the LGBTQ+ rights movement, the book shines a light on the beauty of love in its many forms and the importance of fighting for it. Passionate, raw, and deeply moving, this book is a testament to the power of unity and authenticity.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            color: Colors.white54,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/stereotype.jpg',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Breaking the Stereotype',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Raj Malhotra',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'In Breaking the Stereotype, Raj Malhotra tackles the rigid perceptions and biases society places on individuals based on their gender, appearance, and lifestyle. This book features interviews, personal anecdotes, and a collection of real-life stories from people around the world who have faced stereotyping head-on. Through engaging storytelling, it highlights the dangers of pigeonholing people and the necessity of breaking free from society’s harmful labels.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            color: Colors.white54,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/rainbow.jpg',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                const Text(
                  'The Rainbow Within',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Lila Henderson',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "The Rainbow Within tells the story of Emma, a young woman navigating her journey through self-discovery, identity, and love. Set in a small, conservative town, Emma learns the importance of self-acceptance and how love knows no boundaries. This heartwarming novel explores the struggles of coming out, societal pressure, and finding solace in embracing one's true self. With poignant relationships and emotional twists, The Rainbow Within is a powerful narrative of courage and hope.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
