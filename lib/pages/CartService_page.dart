import 'package:ecommerce/data/products.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartService {
  static const String cartKey = "cart";

  

  // Sauvegarder le panier
  static Future<void> saveCart(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = products.map((p) => p.toJson()).toList();
    await prefs.setStringList(cartKey, data);
  }

  // Charger le panier
  static Future<List<Product>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList(cartKey);
    if (data == null) return [];
    return data.map((e) => Product.fromJson(e)).toList();
  }

  // Vider panier après paiement
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartKey);
  }
}
