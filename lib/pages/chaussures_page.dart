import 'package:ecommerce/pages/CategoryPage.dart';
import 'package:flutter/material.dart';

class ChaussuresPage extends StatelessWidget {
  const ChaussuresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(
      title: "Chaussures",
      collectionName: "chaussure",

    );
  }
}
