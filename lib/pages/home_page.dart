import 'package:ecommerce/pages/book_page.dart';
import 'package:ecommerce/pages/electroniques_pages.dart';
import 'package:ecommerce/pages/gaming_pages.dart';
import 'package:ecommerce/services/firebase/auth.dart';
//import 'package:ecommerce/widget/popular_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/widget/category_item.dart';
import 'vetements_page.dart';
import 'chaussures_page.dart';
import 'accessoires_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final User? user = Auth().currentUser;

  final CollectionReference _collection= FirebaseFirestore.instance.collection('products');
  final CollectionReference _nouveaute=FirebaseFirestore.instance.collection('nouveaute');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopApp'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.shopping_cart)
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Auth().logout();
            },
          ),
          
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// USER
              Text(
                'Bienvenue ${user?.email ?? ''}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              /// TITRE
              const Text(
                'Catégories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              /// CATEGORIES
              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryItem(
                      title: 'Vêtements',
                      icon: Icons.checkroom,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VetementsPage(),
                          ),
                        );
                      },
                    ),
                    CategoryItem(
                      title: 'Chaussures',
                      icon: Icons.directions_run,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChaussuresPage(),
                          ),
                        );
                      },
                    ),
                    CategoryItem(
                      title: 'Accessoires',
                      icon: Icons.watch,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AccessoiresPage(),
                          ),
                        );
                      },
                    ),
                    CategoryItem(
                      title: 'Electroniques',
                      icon: Icons.phone_iphone,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ElectroniquesPage(),
                          ),
                        );
                      },
                    ),
                    CategoryItem(
                      title: 'Gaming',
                      icon: Icons.sports_esports,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GamingPage(),
                          ),
                        );
                      },
                    ),
                    CategoryItem(
                      title: 'Books',
                      icon: Icons.book,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BookPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// TITRE PRODUITS POPULAIRES + BOUTON VOIR TOUT
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Produits Populaires',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AllProductsPage(),
                        ),
                      );
                    },
                    child: const Text('Voir tout →'),
                  ),
                ],
              ),

              const SizedBox(height: 12),
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
                                    const SizedBox(height: 8),
                                    Text(
                                      "${data['price']} FBU • ⭐ ${data['rating']}",
                                      textAlign: TextAlign.center,
                                    ),
                                    Spacer(),//pour pousser le bouton vers le bas
                                    //SizedBox(height: 50,),
                                    ElevatedButton(
                                      onPressed: (){},
                                      child: Text("Ajouter au panier"),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),




             
              const SizedBox(height: 30),

              /// SECTION NOUVEAUTÉS
              const Text(
                'Nouveautés',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

     StreamBuilder<QuerySnapshot>(
        stream: _nouveaute.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Center(child: Text("Erreur avec la base de donnee"),);
          }if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Aucun produit disponible"));
          }

           if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

           final collection = snapshot.data!.docs;
          return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: collection.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // nombre de colonnes
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 2, // largeur / hauteur des cartes
                          ),
                          itemBuilder: (context, index) {
                            final data = collection[index];

                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                                    const SizedBox(height: 8),
                                    Text(
                                      "${data['price']} FBU • ⭐ ${data['badge']}",
                                      textAlign: TextAlign.center,
                                    ),
                                    Spacer(),//pour pousser le bouton vers le bas
                                    //SizedBox(height: 50,),
                                    ElevatedButton(
                                      onPressed: (){},
                                      child: Text("Ajouter au panier"),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
        }
        ),
             
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// PAGE "VOIR TOUS LES PRODUITS"
class AllProductsPage extends StatelessWidget {
  const AllProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tous les produits'),
      ),
      // body: GridView.builder(
      //   padding: const EdgeInsets.all(16),
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     crossAxisSpacing: 12,
      //     mainAxisSpacing: 12,
      //     childAspectRatio: 0.65,
      //   ),
      //   itemCount: ProductsData.allProducts.length,
      //   itemBuilder: (context, index) {
      //     return ProductsData.allProducts[index];
      //   },
      // ),
    );
  }
}