import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryProductScreen extends StatelessWidget {
  final dynamic categoryData;

  const CategoryProductScreen({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: categoryData['categoryName'])
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryData['categoryName'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

           if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'Không có sản phẩm trong danh mục',style: TextStyle(fontSize: 22, color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
            );
          }

          return GridView.builder(
             itemCount: snapshot.data!.size,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 200 / 300),
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                return Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Container(
                          height: 170,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
          
                                productData['imageUrl'][0],
          
                              ),
                            ),
                          ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(productData['productName'],style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                               
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('\$' +
                                  " " +
                                  productData['productPrice'].toStringAsFixed(2),
                                   style: TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.bold,
                                     color: const Color.fromARGB(255, 236, 33, 6),
                                   )),
                          )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
