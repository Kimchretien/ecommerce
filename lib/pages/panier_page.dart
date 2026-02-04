import 'package:ecommerce/data/products.dart';
import 'package:ecommerce/pages/CartService_page.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product> cart = [];
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  // Charger le panier depuis SharedPreferences
  void loadCartItems() async {
    List<Product> loadedCart = await CartService.loadCart();
    setState(() {
      cart = loadedCart;
      totalPrice = calculateTotal(loadedCart);
    });
  }

  // Calculer le total
  int calculateTotal(List<Product> products) {
    int total = 0;
    for (var p in products) {
      total += p.price;
    }
    return total;
  }

  // Supprimer un produit du panier
  void removeFromCart(Product product) async {
    cart.remove(product); // retirer de la liste locale
    await CartService.saveCart(cart); // sauvegarder dans SharedPreferences
    setState(() {
      totalPrice = calculateTotal(cart); // recalculer le total
    });
  }

  // Vider le panier après paiement
  void clearCart() async {
    await CartService.clearCart();
    setState(() {
      cart = [];
      totalPrice = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mon Panier")),
      body: cart.isEmpty
          ? Center(child: Text("Votre panier est vide"))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                Product p = cart[index];
                return ListTile(
                  title: Text(p.name),
                  subtitle: Text("${p.price} FBU"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      removeFromCart(p);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Ici tu déclenches le paiement
                  // Après paiement :
                  clearCart();
                },
                child: Text("Payer (${cart.length} produits) - Total: $totalPrice FBU"),
              ),
            ),
    );
  }
}
