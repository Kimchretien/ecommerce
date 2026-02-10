import 'package:ecommerce/pages/CategoryPage.dart';
import 'package:flutter/material.dart';


class ElectroniquesPages extends StatelessWidget {
  const ElectroniquesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(
      title: "Électroniques",
      collectionName: "electronique",
    );
  }
}
