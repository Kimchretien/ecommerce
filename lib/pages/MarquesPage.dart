import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'CategoryPage.dart';

class MarquesPage extends StatelessWidget {
  final String collectionName; // ex: "vetements"
  final String subCategory; // ex: "Costume"

  const MarquesPage({
    super.key,
    required this.collectionName,
    required this.subCategory,
  });

  @override
  Widget build(BuildContext context) {
    final productsCollection = FirebaseFirestore.instance.collection(collectionName);

    return StreamBuilder<QuerySnapshot>(
      stream: productsCollection
          .where("subcategory", isEqualTo: subCategory)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        // Extraire toutes les marques uniques
        final docs = snapshot.data!.docs;
        final brands = docs
            .map((doc) => (doc.data() as Map<String, dynamic>)["brand"])
            .toSet()
            .toList();

        return Scaffold(
          appBar: AppBar(title: Text(subCategory)),
          body: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3/2,
            ),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryPage(
                        title: brand,
                        collectionName: collectionName,
                        brandFilter: brand, // filtre les produits par marque
                      ),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      brand,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
