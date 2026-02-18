import 'package:ecommerce/pages/CategoryPage.dart';
import 'package:flutter/material.dart';


class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(
      title: "Livres",
      collectionName: "books",
     
    );
  }
}
