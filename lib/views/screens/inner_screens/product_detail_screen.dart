import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoutout_shop_app/provider/cart_provider.dart';
import 'package:shoutout_shop_app/provider/selected_size_provider.dart';
import 'package:shoutout_shop_app/views/screens/inner_screens/chat_screen.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final dynamic productData;

  ProductDetailScreen({super.key, required this.productData});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final selectedSize = ref.watch(selectedSizeProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    final cartItem = ref.watch(cartProvider);
    final isInCart = cartItem.containsKey(widget.productData['productId']);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.productData['imageUrl'][_imageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['imageUrl'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _imageIndex = index;
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.pink.shade900),
                              ),
                              child: Image.network(
                                  widget.productData['imageUrl'][index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productData['productName'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.productData['productPrice'].toStringAsFixed(3) +
                        " \VND",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Thông tin sản phẩm',
                          style: TextStyle(
                            color: Colors.pink,
                          ),
                        ),
                        Text(
                          'Xem thêm',
                          style: TextStyle(
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.productData['description'],
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                            // letterSpacing: 3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    title: Text(
                      'Kích cỡ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Container(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.productData['sizeList'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    final newSelected =
                                        widget.productData['sizeList'][index];

                                    ref
                                        .read(selectedSizeProvider.notifier)
                                        .setSelectedSize(newSelected);
                                  },
                                  child: Text(
                                      widget.productData['sizeList'][index])),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        widget.productData['storeImage'],
                      ),
                    ),
                    title: Text(
                      widget.productData['bussinessName'].toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    subtitle: Text(
                      'Thông tin',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          InkWell(
            onTap: isInCart
                ? null
                : () {
                    _cartProvider.addProductToCart(
                        widget.productData['productName'],
                        widget.productData['productId'],
                        widget.productData['imageUrl'],
                        1,
                        widget.productData['productQuantity'],
                        widget.productData['productPrice'],
                        widget.productData['vendorId'],
                        selectedSize);

                    print(_cartProvider.getCartItems.values.first.productName);
                  },
            child: Container(
              decoration: BoxDecoration(
                color: isInCart
                    ? const Color.fromARGB(200, 231, 45, 45)
                    : const Color.fromARGB(180, 243, 97, 19),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.shopping_cart,
                      color: Colors.white,
                    ),
                    Text(
                      isInCart ? "Trong giỏ hàng" : 'Thêm vào giỏ hàng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ChatScreen(
                  sellerId: widget.productData['vendorId'],
                  buyerId: FirebaseAuth.instance.currentUser!.uid,
                  productId: widget.productData['productId'],
                  productName: widget.productData['productName'],


                );
              }));
            },
            icon: Icon(
              Icons.chat_bubble,
              color: const Color.fromARGB(180, 243, 97, 19),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.phone,
              color: const Color.fromARGB(180, 243, 97, 19),
            ),
          ),
        ]),
      ),
    );
  }
}
