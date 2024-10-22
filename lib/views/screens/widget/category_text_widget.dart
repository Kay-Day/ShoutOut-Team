import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoutout_shop_app/views/screens/category.Screen.dart';

class CategoryTextWidget extends StatefulWidget {
  const CategoryTextWidget({super.key});

  @override
  State<CategoryTextWidget> createState() => _CategoryTextWidgetState();
}

class _CategoryTextWidgetState extends State<CategoryTextWidget> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danh mục',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading danh mục ");
              }

              return Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                      final categoryData = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ActionChip(
                          onPressed: (){
                            
                          },
                            backgroundColor: const Color.fromARGB(255, 238, 242, 242),
                            label: Center(
                          child: Text(categoryData['categoryName'].toUpperCase(), style: TextStyle(
                                      color: const Color.fromARGB(255, 243, 88, 61),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),),
                        ),),
                      );
                    },
                    ),
                    ),
                    IconButton(
                       onPressed: () {
                        Get.to(CategoryScreen());
                      },
                       icon: Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),


                
              );
            },
          ),
        ],
      ),
    );
  }
}
