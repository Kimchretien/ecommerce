//import 'package:ecommerce/widget/chaussure_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/widget/chaussure_item.dart';
import 'package:flutter/material.dart';

class ChaussuresPage extends StatelessWidget {
   ChaussuresPage({super.key});


   

  final CollectionReference _chaussure= FirebaseFirestore.instance.collection('chaussure');
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
              await _chaussure.doc(data.id).update({
                'name': _namecontroller.text,
              });;


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

void _showAddDialog(BuildContext context,) {


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
              await _chaussure.add({
                'name': _namecontroller.text,
              });


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
          StreamBuilder<QuerySnapshot>(
                      stream: _chaussure.snapshots(),
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
                            final  data = products[index];

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
                                       const Spacer(),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      //_showEditDialog(data);
                                      _showEditDialog(data, context);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      await _chaussure.doc(data.id).delete();
                                    },
                                  ),
                                ],
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

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showAddDialog(context);
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
