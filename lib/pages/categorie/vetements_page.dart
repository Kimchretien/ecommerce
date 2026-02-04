import 'package:flutter/material.dart';

class VetementsPage extends StatelessWidget {
  const VetementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vêtements'),
      ),
      body: const Center(
        child: Text(
          'Liste des vêtements',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
