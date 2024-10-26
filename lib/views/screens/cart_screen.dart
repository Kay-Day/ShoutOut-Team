
import 'package:flutter/cupertino.dart';
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
    final cartData = ref.watch(cartProvider);
    return ListView.builder(
      itemCount: cartData.length,
      itemBuilder: (context, index){
        final cartItem = cartData.values.toList()[index];
    
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(cartItem.productName),
               Text(cartItem.quantity.toString()),
            ],
          ),
        );
    
    
    });
  }
}