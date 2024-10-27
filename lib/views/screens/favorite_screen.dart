import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoutout_shop_app/provider/favorite_provider.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final _favoriteProvider = ref.read(favoriteProvider.notifier);
    final _wishItem = ref.watch(favoriteProvider);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.pink,
          elevation: 0,
          title: Text(
            'Danh mục yêu thích',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // letterSpacing: 4,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                   _favoriteProvider.removeAllItems();
                },
                icon: Icon(
                  CupertinoIcons.delete,
                ))
          ],
        ),
        body: _wishItem.isNotEmpty
          ?  ListView.builder(
           shrinkWrap: true,
            itemCount: _wishItem.length,
            itemBuilder: (context, index) {
              final wishData = _wishItem.values.toList()[index];
              return Card(
                child: SizedBox(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(wishData.imageUrl[0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                  wishData.productName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    // letterSpacing: 5,
                                  ),
                                ),
                                Text(
                                  wishData.price.toStringAsFixed(3)+ " \VND",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    // letterSpacing: 5,
                                    color: Colors.pink,
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  _favoriteProvider.removeItem(wishData.productId);
                         
                                }, icon: Icon(
                                  Icons.cancel,
                                ),
                                ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            ):Center(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  Text(
                    'Danh mục yêu thích của bạn trống',
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
                    "Bạn chưa thêm sản phẩm nào yêu thích của bạn.\n Bạn có thể thêm sản phẩm từ màn hình chính",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 ],
              ),

            ),
            );
  }
}
