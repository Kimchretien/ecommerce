import 'dart:convert';

class Product {
  final String id;
  final String name;
  final int price;

  Product({required this.id, required this.name, required this.price});

  // Convertir Product en Map (pour sauvegarde JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  // Créer un Product à partir d'une Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }

  // Convertir en JSON string
  String toJson() => jsonEncode(toMap());

  // Créer un Product depuis JSON string
  factory Product.fromJson(String source) =>
      Product.fromMap(jsonDecode(source));
}
