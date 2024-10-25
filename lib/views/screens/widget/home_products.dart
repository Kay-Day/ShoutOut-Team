import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoutout_shop_app/views/screens/widget/product_model.dart';

class HomeproductWidget extends StatelessWidget {
  const HomeproductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Container(
            height: 100,
            child: PageView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final prouctData = snapshot.data!.docs[index];
                  return ProductModel(prouctData: prouctData);
                }));
      },
    );
  }
}
