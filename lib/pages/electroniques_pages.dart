import 'package:flutter/material.dart';

class ElectroniquesPage extends StatelessWidget {
  const ElectroniquesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electroniques'),
      ),
      body: const Center(
        child: Text(
          'Liste des Electroniques',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
