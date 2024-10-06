
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoutout_shop_app/views/screens/account_screen.dart';
import 'package:shoutout_shop_app/views/screens/cart_screen.dart';
import 'package:shoutout_shop_app/views/screens/category.Screen.dart';
import 'package:shoutout_shop_app/views/screens/favorite_screen.dart';
import 'package:shoutout_shop_app/views/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    FavoriteScreen(),
    // SearchScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pink,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/home1.png',
              fit: BoxFit.cover,
              width: 20,
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/shopping-bag.png',
              width: 20,
            ),
            label: 'Sản phẩm',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/shopping-cart.png',width: 20,),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/lover.png',width: 20,),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/product.png',width: 20,),
            label: 'Tìm kiếm',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/account.svg'),
            label: 'Tài khoản',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}

