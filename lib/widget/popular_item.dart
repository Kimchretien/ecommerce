import 'package:flutter/material.dart';


class PopularItem extends StatelessWidget{
  final String name;
  final IconData icon;
  final double price;
  final double rating;
  final int reviews;
  final String badge;

  const PopularItem({
    super.key,
    required this.name,
    required this.icon,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.badge

    });
}