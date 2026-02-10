import 'package:ecommerce/data/products.dart';
import 'package:ecommerce/pages/CartService_page.dart';
import 'package:ecommerce/pages/book_page.dart';
import 'package:ecommerce/pages/electroniques_pages.dart';
import 'package:ecommerce/pages/gaming_pages.dart';
import 'package:ecommerce/pages/panier_page.dart';
import 'package:ecommerce/services/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/widget/category_item.dart';
import 'package:flutter/services.dart';
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


List<Product> panier = [];

  final User? user = Auth().currentUser;

  final CollectionReference _collection= FirebaseFirestore.instance.collection('products');
  final CollectionReference _nouveaute=FirebaseFirestore.instance.collection('nouveaute');
  final TextEditingController _namecontroller=TextEditingController();
  final TextEditingController _pricecontroller=TextEditingController();

void addToCart(Product product) async {
  // Charger le panier actuel
  List<Product> currentCart = await CartService.loadCart();

  // Ajouter le nouveau produit
  currentCart.add(product);

  // Sauvegarder à nouveau le panier
  await CartService.saveCart(currentCart);

  // print("Produit ajouté au panier : ${product.name}");
}


  void _showEditDialog(BuildContext context, QueryDocumentSnapshot data) {
  _namecontroller.text = data['name'];
  _pricecontroller.text = data['price'].toString();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Modifier le produit"),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _namecontroller,
                decoration: const InputDecoration(
                  labelText: "Nom du produit",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _pricecontroller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  labelText: "Prix",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              await _nouveaute.doc(data.id).update({
                'name': _namecontroller.text,
                'price': int.parse(_pricecontroller.text),
              });
                if (!mounted) return;


              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Produit modifié ✔")),
              );
            },
            child: const Text("Enregistrer"),
          ),
        ],
      );
    },
  );
}

 // final Map<String, bool> _isEditingMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopApp'),
        actions: [
          IconButton(
            onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(),
      ),
    );
  }, 
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
                            builder: (_) =>  VetementsPage(),
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
                            builder: (_) =>  ChaussuresPage(),
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
                            builder: (_) =>  AccessoiresPage(),
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
                            builder: (_) =>  ElectroniquesPages(),
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
                            builder: (_) =>  GamingPages(),
                          ),
                        );
                      },
                    ),
                    CategoryItem(
                      title: 'Livres',
                      icon: Icons.book,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>  BookPage(),
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
                                          onPressed: () {
                                            Product p = Product(
                                              id: data.id,
                                              name: data['name'],
                                              price: data['price'],
                                            );

                                            addToCart(p);
                                             ScaffoldMessenger.of(context).showSnackBar(
                                             SnackBar(content: Text("${p.name} ajouté au panier ✅")),
                                           );
                                          },
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
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    childAspectRatio: 3 / 3.5, // cartes un peu plus hautes
  ),
  itemBuilder: (context, index) {
    final data = collection[index];

    // Récupération sécurisée de l'image
    final Map<String, dynamic>? dataMap = data.data() as Map<String, dynamic>?;
    final imageUrl = (dataMap != null && dataMap.containsKey('images'))
        ? dataMap['images']
        : 'https://via.placeholder.com/300';

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // Action clic sur la carte si nécessaire
        },
        child: Stack(
          children: [
            // 1️⃣ Image en background
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 40, color: Colors.red),
              ),
            ),

            // 2️⃣ Contenu par-dessus l'image
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${data['price']} FBU",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () => _showEditDialog(context, data),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await _nouveaute.doc(data.id).delete();
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Product p = Product(
                        id: data.id,
                        name: data['name'],
                        price: data['price'],
                      );
                      addToCart(p);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${p.name} ajouté au panier ✅")),
                      );
                    },
                    child: const Text("Ajouter au panier"),
                  ),
                ],
              ),
            ),
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



