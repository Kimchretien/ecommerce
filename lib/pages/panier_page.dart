import 'package:flutter/material.dart';
import 'package:ecommerce/data/products.dart';

class PanierPage extends StatelessWidget {
  final List<Product> panier;

  const PanierPage({super.key, required this.panier});

  @override
  Widget build(BuildContext context) {
    int total = panier.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: const Text("Panier")),
      body: panier.isEmpty
          ? const Center(child: Text("Votre panier est vide"))
          : ListView.builder(
              itemCount: panier.length,
              itemBuilder: (context, index) {
                final item = panier[index];
                return ListTile(
                  title: Text(item.name),
                  trailing: Text("${item.price} FBU"),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.blueGrey[50],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total: $total FBU", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                // Tu peux ajouter la logique de paiement ici
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Paiement effectué ✔")),
                );
              },
              child: const Text("Payer"),
            )
          ],
        ),
      ),
    );
  }
}
