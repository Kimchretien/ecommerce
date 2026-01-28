import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book'),
      ),
      body: const Center(
        child: Text(
          'Liste des livres',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
