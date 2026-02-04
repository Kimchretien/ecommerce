import 'package:ecommerce/widget/chaussure_item.dart';
import 'package:flutter/material.dart';

class ChaussuresPage extends StatelessWidget {
  const ChaussuresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chaussures'),
      ),
      body:SingleChildScrollView(
        // child: Column(
        //   children: [
        //    // ChaussureItem(name: 'Nike', icon: Icon(Icons.), 
        //     //onTap: (context,MaterialPageRoute(builder(_)=>)){}
        //     )
        //   ],
        // ), 

      )
    );
  }
}
