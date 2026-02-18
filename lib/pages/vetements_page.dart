import 'package:ecommerce/pages/CategoryPage.dart';
import 'package:ecommerce/pages/chaussureDetailsPage.dart';
import 'package:flutter/material.dart';


class VetementsPage extends StatelessWidget {
  const VetementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(
      title: "Vêtements",
      collectionName: "Vetements",
       navigationPushed: (data) =>
          ChaussureDetailsPage(product: data),
    );
  }
}
