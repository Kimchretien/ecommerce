import 'package:ecommerce/pages/CategoryPage.dart';
import 'package:flutter/material.dart';


class GamingPages extends StatelessWidget {
  const GamingPages({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(
      title: "Jeux Vidéo",
      collectionName: "gaming",
    );
  }
}
