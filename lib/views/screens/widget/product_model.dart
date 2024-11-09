import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoutout_shop_app/provider/favorite_provider.dart';
import 'package:shoutout_shop_app/views/screens/inner_screens/product_detail_screen.dart';

class ProductModel extends ConsumerStatefulWidget {
  const ProductModel({
    super.key,
    required this.prouctData,
  });

  final QueryDocumentSnapshot<Object?> prouctData;

  @override
  _ProductModelState createState() => _ProductModelState();
}

class _ProductModelState extends ConsumerState<ProductModel> {
  @override
  Widget build(BuildContext context) {
    final _favoriteProvider = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context){
          return ProductDetailScreen(productData: widget.prouctData,);

        }));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xf000000),
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.prouctData['imageUrl'][0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.prouctData['productName'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(200, 7, 7, 7),
                        ),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                       
                        widget.prouctData['productPrice']
                            .toStringAsFixed(3)
                            + " \VND",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 240, 27, 12))
                      ),
                      widget.prouctData['rating'] == 0
                      ? SizedBox()
                      :Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber,
                          size: 14,),
                          Text(
                            widget.prouctData['rating'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          )
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 15,
            child: IconButton(onPressed: (){
              _favoriteProvider.addProductToFavorite(
                        widget.prouctData['productName'], 
                        widget.prouctData['productId'],
                        widget.prouctData['imageUrl'],
                        1,
                        widget.prouctData['productQuantity'],
                        widget.prouctData['productPrice'],
                        widget.prouctData['vendorId'],
                        );
            }, icon: _favoriteProvider.getFavoriteItem.containsKey(widget.prouctData['productId'])? Icon(
              Icons.favorite,color: Colors.red,
              ):Icon(Icons.favorite_border, color: Colors.red,),
              ),
              ),
        ],
      ),
    );
  }
}
