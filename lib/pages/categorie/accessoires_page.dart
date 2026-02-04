import 'package:flutter/material.dart';

class AccessoiresPage extends StatelessWidget {
  const AccessoiresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessoires'),
      ),
      body: const Center(
        child: Text(
          'Liste des accessoires',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
