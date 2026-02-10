import 'package:ecommerce/pages/CategoryPage.dart';
import 'package:flutter/material.dart';


class AccessoiresPage extends StatelessWidget {
  const AccessoiresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(
      title: "Accessoires",
      collectionName: "accessoires",
    );
  }
}
