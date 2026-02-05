import 'package:ecommerce/data/products.dart';
import 'package:flutter/material.dart';

// Page de détail du produit
class ProductDetailPage extends StatelessWidget {
  final dynamic product; // Le produit passé depuis le GridView

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1️⃣ Image en grand
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product['images'] ?? 'https://via.placeholder.com/300',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 80, color: Colors.red),
              ),
            ),
            const SizedBox(height: 20),

            // 2️⃣ Nom et prix
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            // 3️⃣ Bouton Ajouter au panier
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Product p = Product(
                      id: product.id,
                      name: product['name'],
                      price: product['price'],
                    );
                    addToCart(p); // Ta fonction existante
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${p.name} ajouté au panier ✅"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Ajouter au panier",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void addToCart(Product p) {}
}
