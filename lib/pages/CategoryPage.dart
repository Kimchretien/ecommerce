import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/pages/panier_page.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String title;
  final String collectionName;
  //final Widget NavigationPushed;

  
final String? brandFilter;

CategoryPage({
  super.key,
  required this.title,
  required this.collectionName,
  this.brandFilter,
});



  final TextEditingController _nameController = TextEditingController();

  CollectionReference get collection =>
      FirebaseFirestore.instance.collection(collectionName);

  void _showAddDialog(BuildContext context) {
    _nameController.clear();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Ajouter un produit"),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: "Nom du produit"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              await collection.add({
                "name": _nameController.text,
              });
              Navigator.pop(context);
            },
            child: const Text("Ajouter"),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, QueryDocumentSnapshot data) {
    _nameController.text = data["name"];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Modifier"),
        content: TextField(
          controller: _nameController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await collection.doc(data.id).update({
                "name": _nameController.text,
              });
              Navigator.pop(context);
            },
            child: const Text("Enregistrer"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),

      appBar: AppBar(
        title: Text(title),
        actions:  [
                    IconButton(
            onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(),
      ),
    );
  }, 
            icon: Icon(Icons.shopping_cart_checkout)
            ),
          SizedBox(width: 10),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: StreamBuilder<QuerySnapshot>(
          stream: brandFilter == null
         ? collection.snapshots()
         : collection.where("brand", isEqualTo: brandFilter).snapshots(),

          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final products = snapshot.data!.docs;

            return GridView.builder(
              padding: const EdgeInsets.only(bottom: 90),
              itemCount: products.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, index) {
                final data = products[index];
                final map =
                    data.data() as Map<String, dynamic>?;

                final imageUrl =
                    map != null && map.containsKey("images")
                        ? map["images"]
                        : "https://via.placeholder.com/300";

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                   onTap: () {
                        
                        },

                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                data["name"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    onPressed: () =>
                                        _showEditDialog(
                                            context, data),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await collection
                                          .doc(data.id)
                                          .delete();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        icon: const Icon(Icons.add),
        label: const Text("Ajouter"),
      ),
    );
  }
}
