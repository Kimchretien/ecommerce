//import 'package:ecommerce/widget/chaussure_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/pages/productDetail.dart';
import 'package:ecommerce/widget/chaussure_item.dart';
import 'package:flutter/material.dart';

class ElectroniquesPages extends StatelessWidget {
   ElectroniquesPages({super.key});


   

  final CollectionReference _electronique= FirebaseFirestore.instance.collection('electronique');
  final TextEditingController _namecontroller =TextEditingController();




  void _showEditDialog(QueryDocumentSnapshot data, BuildContext context) {
  _namecontroller.text = data['name'];

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
              await _electronique.doc(data.id).update({
                'name': _namecontroller.text,
              });;


              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(

                const SnackBar(content: Text("Produit modifié ✔"),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),)
                ,
                ),
              );
            },
            child: const Text("Enregistrer"),
          ),
        ],
      );
    },
  );
}

void _showAddDialog(BuildContext context,) {


  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Ajouter un produit"),
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
              await _electronique.add({
                'name': _namecontroller.text,
              });


              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Produit ajouter avec succes ✔"),),
              );
            },
            child: const Text("Enregistrer"),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
          StreamBuilder<QuerySnapshot>(
                      stream: _electronique.snapshots(),
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
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1, // largeur / hauteur des cartes
                                ),
                                itemBuilder: (context, index) {
                                  final data = products[index];
                                // Récupération sécurisée de l'image
                              final Map<String, dynamic>? dataMap = data.data() as Map<String, dynamic>?;

                              final imageUrl = (dataMap != null && dataMap.containsKey('images'))
                                  ? dataMap['images']
                                  : 'https://via.placeholder.com/300';


                                  return Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: (){},
                                     //onTap: () {
                                                  //   Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //       builder: (context) => ProductDetailPage(product: data),
                                                  //     ),
                                                  //   );
                                                  // },

                                      child: Stack(
                                        children: [
                                          // 1️⃣ Image en background qui remplit tout
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network(
                                              imageUrl,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                              errorBuilder: (context, error, stackTrace) =>
                                                  const Icon(Icons.error, size: 40, color: Colors.red),
                                            ),
                                          ),

                                          // 2️⃣ Contenu au-dessus de l'image (titre + boutons)
                                          Positioned(
                                            bottom: 8,
                                            left: 8,
                                            right: 8,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(Icons.edit, color: Colors.white),
                                                      onPressed: () => _showEditDialog(data, context),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(Icons.delete, color: Colors.red),
                                                      onPressed: () async {
                                                        await _electronique.doc(data.id).delete();
                                                      },
                                                    ),
                                                  ],
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

                      },
                    ),

          ],
        ), 

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showAddDialog(context);
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
