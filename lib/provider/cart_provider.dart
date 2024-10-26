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
  Map<String , CartModel>get getCartItems => state;
}
