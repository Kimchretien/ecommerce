//import 'package:ecommerce/widget/chaussure_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/widget/chaussure_item.dart';
import 'package:flutter/material.dart';

class ChaussuresPage extends StatelessWidget {
   ChaussuresPage({super.key});

  final CollectionReference _collection= FirebaseFirestore.instance.collection('chaussure');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chaussures'),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
          StreamBuilder<QuerySnapshot>(
                      stream: _collection.snapshots(),
                       builder: (context, snapshot) {
                        // 1️⃣ Chargement
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        // 2️⃣ Erreur
                        if (snapshot.hasError) {
                          return const Center(child: Text("Erreur Firebase"));
                        }

                        // 3️⃣ Aucune donnée
                        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text("Aucun produit"));
                        }

                        // 4️⃣ Données OK ✅
                        final products = snapshot.data!.docs;

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // nombre de colonnes
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 2, // largeur / hauteur des cartes
                          ),
                          itemBuilder: (context, index) {
                            final data = products[index];

                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                 // print("Produit cliqué : ${data['name']}");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        data['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                          },
                        );
                      },
                    ),

          ],
        ), 

      )
    );
  }
}
