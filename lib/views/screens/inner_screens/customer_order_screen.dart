import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerOrderScreen extends StatelessWidget {
 

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String formateDate(date){
    final outPutdateFormate = DateFormat("dd/MM/yyyy");

    final outPutDate = outPutdateFormate.format(date);

    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream =
        FirebaseFirestore.instance.collection('orders').where('buyerId',isEqualTo: _auth.currentUser!.uid).snapshots();
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
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
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
                  ExpansionTile(title: Text('Chi tiết đơn hàng',
                  style: TextStyle(
                    color: Colors.orange
                  ),
                  ),
                  subtitle: Text(
                    'Xem thông tin đơn hàng'
                  ),
                  children: [
                    ListTile(
                      leading: CircleAvatar(child: Image.network(data['productImage'][0]
                      ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['productName'],style:TextStyle(fontWeight: FontWeight.bold
                          ) ,
                          ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Số lượng',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                            Text(data['quantity'].toString(),style: TextStyle(color: Colors.red),)
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
                            Text(data['fullName'],style: TextStyle(fontSize: 15,
                            fontWeight: FontWeight.bold),
                            ),
                            Text(data['email'],style: TextStyle(fontSize: 15,
                            fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Ngày đặt hàng:   " + formateDate(data['orderDate'].toDate(),
                              ),
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                              ),
                            ),
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
