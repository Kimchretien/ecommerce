import 'package:ecommerce/pages/MarquesPage.dart';
import 'package:ecommerce/widget/category_item.dart';
import 'package:flutter/material.dart'; // ton widget pour les cartes

class SousCategoriesPage extends StatelessWidget {
  final String categoryTitle; // ex: "Vêtements"
  final String collectionName; // ex: "vetements"
  final List<String> subCategories; // ex: ["Costume","T-shirt","Jeans","Robe"]

  const SousCategoriesPage({
    super.key,
    required this.categoryTitle,
    required this.collectionName,
    required this.subCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3/2,
          ),
          itemCount: subCategories.length,
          itemBuilder: (context, index) {
            final subCat = subCategories[index];
            return CategoryItem(
              title: subCat,
              icon: Icons.category, // tu peux mettre un icône différent si tu veux
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MarquesPage(
                      collectionName: collectionName,
                      subCategory: subCat,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
