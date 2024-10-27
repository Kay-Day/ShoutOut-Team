import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoutout_shop_app/models/favorite_models.dart';

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, Map<String, FavoriteModels>>(
  (ref){
    return FavoriteNotifier();
  }
);

class FavoriteNotifier extends StateNotifier<Map<String, FavoriteModels>> {
  FavoriteNotifier() : super({});

  void addProductToFavorite(
    String productName,
    String productId,
    List imageUrl,
    int quantity,
    int productQuantity,
    double price,
    String vendorId,
    
  ) {
    state[productId] = FavoriteModels(
        productName: productName,
        productId: productId,
        imageUrl: imageUrl,
        quantity: quantity,
        productQuantity: productQuantity,
        price: price,
        vendorId: vendorId,
        );
        state = {...state};
  }
  void removeAllItems(){
    state.clear();

    state = {...state};
  }
  void removeItem(String productId){
    state.remove(productId);

    state = {...state};

  }
  Map<String, FavoriteModels> get getFavoriteItem => state;
}
