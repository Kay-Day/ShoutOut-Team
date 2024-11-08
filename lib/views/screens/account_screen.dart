import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoutout_shop_app/views/screens/auth/login_screen.dart';
import 'package:shoutout_shop_app/views/screens/inner_screens/customer_order_screen.dart';
import 'package:shoutout_shop_app/views/screens/inner_screens/edit_profile_screen.dart';

class AccountScreen extends StatelessWidget {
   final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
     CollectionReference buyers = FirebaseFirestore.instance.collection('buyers');
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 2,
          // backgroundColor: Colors.pink.shade900,
          title: Text(
            'Thông tin',
            style: TextStyle(fontSize: 20, letterSpacing: 1),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Icon(
                Icons.sunny_snowing,
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
        body: FutureBuilder<DocumentSnapshot>(
      future: buyers.doc(_auth.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return  Center(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage(data['profileImage']),
                // child: Icon(
                //   Icons.person,
                //   size: 50,
                //   color: Colors.white,
                // ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data['fullName'].toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data['email'],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
              width: 200,
               child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return EditProfileScreen();

                }));
               
               }, child: Text('Chỉnh sửa thông tin'),
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Divider(thickness: 2, color: Colors.grey,),
           ),
            ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Cài đặt'),
                      ),
             ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Số điện thoại'),
                        subtitle: Text('0905456456'),
                      ),
             ListTile(
                        leading: Icon(Icons.shop),
                        title: Text('Giỏ hàng'),
                      ),
              ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return CustomerOrderScreen();
                          }));
                         
                        },
                        leading: Icon(CupertinoIcons.shopping_cart),
                        title: Text('Đơn hàng'),
                      ),
              ListTile(
                        onTap: () async {
                           await _auth.signOut().whenComplete(() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CustomerLoginScreen();
                            }));
                          });
                        },
                        leading: Icon(Icons.logout),
                        title: Text('Đăng xuất',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),),
                        
                      ),
            
            ],
          ),
        );
        }

        return Center(child: CircularProgressIndicator(),);
      },
    )
        
        
        
        
        
        
        
        
        
        
       );
  }
}
