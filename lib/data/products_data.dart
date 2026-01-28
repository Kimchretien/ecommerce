import 'package:flutter/material.dart';
import 'package:ecommerce/widget/popular_item.dart';

class ProductsData {
  static List<PopularItem> popularProducts = [
    PopularItem(
      name: 'Telephone',
      icon: Icons.phone_iphone,
      price: 29,
      rating: 4.5,
      reviews: 450,
      badge: '123',
    ),
    PopularItem(
      name: 'Ordinateur Portable',
      icon: Icons.laptop,
      price: 899,
      rating: 4.8,
      reviews: 320,
      badge: '-20%',
    ),
    PopularItem(
      name: 'Montre Connectée',
      icon: Icons.watch,
      price: 199,
      rating: 4.6,
      reviews: 156,
      badge: 'nouveau',
    ),
    PopularItem(
      name: 'Casque Audio',
      icon: Icons.headphones,
      price: 149,
      rating: 4.7,
      reviews: 234,
      badge: '',
    ),
    PopularItem(
      name: 'Tablette Pro',
      icon: Icons.tablet,
      price: 599,
      rating: 4.9,
      reviews: 89,
      badge: '-15%',
    ),
    PopularItem(
      name: 'Appareil Photo',
      icon: Icons.camera_alt,
      price: 799,
      rating: 4.8,
      reviews: 67,
      badge: 'nouveau',
    ),
  ];

  static List<PopularItem> newProducts = [
    PopularItem(
      name: 'Smart TV 4K',
      icon: Icons.tv,
      price: 1299,
      rating: 4.9,
      reviews: 245,
      badge: 'nouveau',
    ),
    PopularItem(
      name: 'Clavier Mécanique',
      icon: Icons.keyboard,
      price: 129,
      rating: 4.6,
      reviews: 178,
      badge: 'nouveau',
    ),
  ];

  // Tous les produits
  static List<PopularItem> allProducts = [
    ...popularProducts,
    ...newProducts,
  ];
}