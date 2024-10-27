import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoutout_shop_app/provider/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final _cartProvider = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final totalAmount = ref.read(cartProvider.notifier).caculateTotalAmount();
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: Colors.pink,
        elevation: 0,
        title: Text(
          'Giỏ hàng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _cartProvider.removeAllItem();
            },
            icon: Icon(
              CupertinoIcons.delete,
            ),
          ),
        ],
      ),
      body:cartData.isNotEmpty? ListView.builder(
          itemCount: cartData.length,
          itemBuilder: (context, index) {
            final cartItem = cartData.values.toList()[index];

            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: SizedBox(
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            cartItem.imageUrl[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItem.productName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                               Text(
                                  cartItem.price.toStringAsFixed(3)+ " \VND",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    // letterSpacing: 5,
                                    color: Colors.pink,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 241, 145, 86),
                                        borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(onPressed: (){
                                            _cartProvider.decrementItem(cartItem.productId);

                                          }, icon: Icon(
                                             CupertinoIcons.minus,
                                              color: Colors.white,
                                              size: 18,
                                          ),
                                          ),
                                          Text(
                                            cartItem.quantity.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          IconButton(
                                            onPressed: (){
                                              _cartProvider.incrementItem(cartItem.productId);

                                            },
                                            icon: Icon(
                                              CupertinoIcons.plus,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          )
                                        ],
                                      )

                                    ),
                                    SizedBox(width: 15,),
                                    IconButton(onPressed: (){
                                        _cartProvider.removeItem(cartItem.productId);
                                    }, icon: Icon(
                                      CupertinoIcons.cart_badge_minus,
                                    ))
                                  ],
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ));
          }):Center(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  Text(
                    'Giỏ hàng của bạn trống',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                     
                    ),
                  ),
                   SizedBox(
                    height: 10,
                  ),
                   Text(
                    "Bạn chưa thêm sản phẩm vào giỏ hàng của bạn.\n Bạn có thể thêm sản phẩm từ màn hình chính",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 ],
              ),

            ),
              bottomNavigationBar: Container(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tổng tiền'+ "  " + totalAmount.toStringAsFixed(3) + ' VND', style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Thanh toán', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
