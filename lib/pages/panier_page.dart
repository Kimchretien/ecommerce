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

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  void loadCartItems() async {
    List<Product> loadedCart = await CartService.loadCart();
    setState(() {
      cart = loadedCart;
    });
  }

  void clearCart() async {
    await CartService.clearCart();
    setState(() {
      cart = [];
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
                child: Text("Payer (${cart.length} produits)"),
              ),
            ),
    );
  }
}
