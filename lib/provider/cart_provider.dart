import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoutout_shop_app/models/cart_models.dart';

final cartProvider = StateNotifierProvider<CartNotifier,Map<String,CartModel>>((ref)=> CartNotifier());
class CartNotifier extends StateNotifier<Map<String, CartModel>> {
  CartNotifier() : super({});

  void addProductToCart(
    final String productName,
    final String productId,
    final List imageUrl,
    int quantity,
    int productQuantity,
    final double price,
    final String vendorId,
    final String productSize,
  ) {
    if (state.containsKey(productId)) {
      state = {
        ...state,
        productId: CartModel(
            productName: state[productId]!.productName,
            productId: state[productId]!.productId,
            imageUrl: state[productId]!.imageUrl,
            quantity: state[productId]!.quantity + 1,
            productQuantity: state[productId]!.productQuantity,
            price: state[productId]!.price,
            vendorId: state[productId]!.vendorId,
            productSize: state[productId]!.productSize)
      };
    } else {
      state = {
        ...state,
        productId: CartModel(
            productName: productName,
            productId: productId,
            imageUrl: imageUrl,
            quantity: quantity,
            productQuantity: productQuantity,
            price: price,
            vendorId: vendorId,
            productSize: productSize)
      };
    }
  }
  void incrementItem(String productId){
    if(state.containsKey(productId)){
      state[productId]!.quantity ++;

      state = {...state};
    }

  }
  void decrementItem(String productId){
    if(state.containsKey(productId)){
      state[productId]!.quantity --;

       state = {...state};
    }

  }

   void removeAllItem(){
    state.clear();

    state = {...state};
  }
  void removeItem(String productId){
    state.remove(productId);

    state = {...state};

  }
 double caculateTotalAmount(){
     double totalAmount = 0.0;
     state.forEach((productId, cartItem){
      totalAmount += cartItem.quantity * cartItem.price;
     });
     return totalAmount;
    
  }
  Map<String , CartModel>get getCartItems => state;
}
