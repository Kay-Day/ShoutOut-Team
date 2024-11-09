import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

class CustomerOrderScreen extends StatefulWidget {
  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  double rating = 0;

  final TextEditingController _reviewController = TextEditingController();

  String formateDate(date) {
    final outPutdateFormate = DateFormat("dd/MM/yyyy");

    final outPutDate = outPutdateFormate.format(date);

    return outPutDate;
  }

  Future<bool> hasUserReviewedProduct(String productId) async {
    final user = FirebaseAuth.instance.currentUser;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('productReviews')
        .where('buyerId', isEqualTo: user!.uid)
        .where('productId', isEqualTo: productId)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

       Future<void> updateProductRating(String productId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('productReviews')
        .where('productId', isEqualTo: productId)
        .get();
    double totalrating = 0;
    int totalReviews = querySnapshot.docs.length;
    for(final doc in querySnapshot.docs){
      totalrating += doc['rating'];
    }
    final double averageRating = totalReviews > 0? totalrating/ totalReviews : 0;

    await FirebaseFirestore.instance.collection('products').doc(productId).update({
      "rating" : averageRating,
      'totalReviews': totalReviews,
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: _auth.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.pink.shade900,
        elevation: 0,
        title: Text(
          'Đơn hàng của tôi',
          style: TextStyle(
            color: const Color.fromARGB(255, 8, 8, 8),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // letterSpacing: 5,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 14,
                        child: data['accepted'] == true
                            ? Icon(Icons.delivery_dining)
                            : Icon(Icons.access_time),
                      ),
                      title: data["accepted"] == true
                          ? Text(
                              'Xác nhận',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 120, 242, 111),
                              ),
                            )
                          : Text(
                              'Chưa xác nhận',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                      trailing: Text(
                        data['price'].toStringAsFixed(3) + " VND",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 6, 6)),
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        'Chi tiết đơn hàng',
                        style: TextStyle(color: Colors.orange),
                      ),
                      subtitle: Text('Xem thông tin đơn hàng'),
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Image.network(data['productImage'][0]),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['productName'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Số lượng',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data['quantity'].toString(),
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                            ],
                          ),
                          subtitle: ListTile(
                            title: Text(
                              'Thông tin người mua hàng',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['fullName'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data['email'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Ngày đặt hàng:   " +
                                        formateDate(
                                          data['orderDate'].toDate(),
                                        ),
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                data['accepted'] == true
                                    ? ElevatedButton(
                                        onPressed: () async {
                                          final productId = data['productId'];
                                          final hasReviewed =
                                              await hasUserReviewedProduct(
                                                  productId);
                                          if (hasReviewed) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Cập nhật đánh giá'),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextFormField(
                                                          controller:
                                                              _reviewController,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Cập nhật đánh giá của bạn',
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              RatingBar.builder(
                                                            initialRating:
                                                                rating,
                                                            itemCount: 5,
                                                            minRating: 1,
                                                            maxRating: 5,
                                                            allowHalfRating:
                                                                true,
                                                            itemSize: 15,
                                                            unratedColor:
                                                                Colors.grey,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            itemBuilder:
                                                                (context, _) {
                                                              return Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              );
                                                            },
                                                            onRatingUpdate:
                                                                (value) {
                                                              rating = value;
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () async {
                                                            final review =
                                                                _reviewController
                                                                    .text;
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'productReviews')
                                                                .doc(data[
                                                                    'orderId'])
                                                                .update({
                                                              'productId': data[
                                                                  'productId'],
                                                              'fullName': data[
                                                                  'fullName'],
                                                              'buyerId': data[
                                                                  'buyerId'],
                                                              'rating': rating,
                                                              'review': review,
                                                              'email':
                                                                  data['email'],
                                                            }).whenComplete(() {
                                                              updateProductRating(productId);
                                                              Navigator.pop(
                                                                  context);
                                                              _reviewController
                                                                  .clear();
                                                            });
                                                          },
                                                          child: Text(
                                                              'Gửi đánh giá'))
                                                    ],
                                                  );
                                                });
                                          } else {
                                                 showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Đánh giá'),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextFormField(
                                                          controller:
                                                              _reviewController,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Đánh giá của bạn',
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              RatingBar.builder(
                                                            initialRating:
                                                                rating,
                                                            itemCount: 5,
                                                            minRating: 1,
                                                            maxRating: 5,
                                                            allowHalfRating:
                                                                true,
                                                            itemSize: 15,
                                                            unratedColor:
                                                                Colors.grey,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            itemBuilder:
                                                                (context, _) {
                                                              return Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              );
                                                            },
                                                            onRatingUpdate:
                                                                (value) {
                                                              rating = value;
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () async {
                                                            final review =
                                                                _reviewController
                                                                    .text;
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'productReviews')
                                                                .doc(data[
                                                                    'orderId'])
                                                                .set({
                                                              'productId': data[
                                                                  'productId'],
                                                              'fullName': data[
                                                                  'fullName'],
                                                              'buyerId': data[
                                                                  'buyerId'],
                                                              'rating': rating,
                                                              'review': review,
                                                              'email':
                                                                  data['email'],
                                                              'buyerPhoto': data['profileImages']
                                                                  
                                                            }).whenComplete(() {
                                                              updateProductRating(productId);
                                                              
                                                              Navigator.pop(
                                                                  context);
                                                              _reviewController
                                                                  .clear();
                                                            });
                                                          },
                                                          child: Text(
                                                              'Gửi đánh giá'))
                                                    ],
                                                  );
                                                });

                                          }
                                        },
                                        child: Text('Đánh giá'))
                                    : Text(''),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
