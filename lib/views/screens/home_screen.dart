
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoutout_shop_app/views/screens/widget/banner_widget.dart';
import 'package:shoutout_shop_app/views/screens/widget/category_text_widget.dart';
import 'package:shoutout_shop_app/views/screens/widget/home_products.dart';
import 'package:shoutout_shop_app/views/screens/widget/location_widget.dart';
import 'package:shoutout_shop_app/views/screens/widget/men_product_widget.dart';
import 'package:shoutout_shop_app/views/screens/widget/reuseText.dart';
import 'package:shoutout_shop_app/views/screens/widget/women_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
     return SingleChildScrollView(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocationWidget(),
          SizedBox(height: 10,),
          BannerWidget(),
          SizedBox(
            height: 10,
          ),
          CategoryItemWidget(),
           SizedBox(
              height: 10,
            ),
            HomeproductWidget(),
            SizedBox(height: 10,),
            ReuseTextWidget(title: "Sản phẩm cho trẻ em"),
       
            SizedBox(height: 10,),
            MenProductWidget(),
            SizedBox(height: 10,),
            ReuseTextWidget(title: "Sản phẩm cho người lớn"),
            SizedBox(height: 10,),
            WomenProductWidget(),


        ],
           ),
     );
  }
}