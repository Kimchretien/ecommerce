import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/products.dart';


class OrderService {

  static Future<String> createOrder(List<Product> cart, int totalPrice) async {
    List<Map<String, dynamic>> items = cart.map((p) => p.toMap()).toList();

    final docRef = await FirebaseFirestore.instance
        .collection("orders")
        .add({
      "items": items,
      "total": totalPrice,
      "status": "pending",
      "createdAt": Timestamp.now(),
    });

    return docRef.id;
  }

  static Future<void> markOrderAsPaid(String orderId) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .update({
          "status": "paid",
        });
  }
}