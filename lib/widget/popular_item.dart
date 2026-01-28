import 'package:flutter/material.dart';

class PopularItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final double price;
  final double rating;
  final int reviews;
  final String badge;

  const PopularItem({
    super.key,
    required this.name,
    required this.icon,
    required this.price,
    required this.rating,
    required this.reviews,
    this.badge = '',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '$price FBU',
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => const Icon(Icons.star, color: Colors.orange, size: 16),
                  ),
                ),
                const SizedBox(width: 8),
                Text('($rating)'),
              ],
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text('$reviews', style: const TextStyle(color: Colors.white)),
              backgroundColor: Colors.red,
            ),
            
            const Spacer(), // ← AJOUTEZ CECI pour pousser le bouton en bas
            
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Ajouter au panier'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 36),
              ),
            ),
          ],
        ),
      ),
    );
  }
}