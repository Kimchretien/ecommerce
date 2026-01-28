import 'package:flutter/material.dart';

class ChaussuresPage extends StatelessWidget {
  const ChaussuresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chaussures'),
      ),
      body: const Center(
        child: Text(
          'Liste des chaussures',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
