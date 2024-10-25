import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoutout_shop_app/views/screens/widget/product_model.dart';

class MenProductWidget extends StatelessWidget {
  const MenProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('products').where('category', isEqualTo: 'Milk').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if(snapshot.data!.docs.isEmpty){
          return Center(child: Text('Không có sản phẩm dành cho trẻ em',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.blueGrey)),);
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
