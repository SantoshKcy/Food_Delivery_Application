import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/account_view.dart';
import 'package:food_delivery_app/view/cart_view.dart';
import 'package:food_delivery_app/view/dashboard_view.dart';
import 'package:food_delivery_app/view/inbox_view.dart';
import 'package:food_delivery_app/view/wishlist_View.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> lstBottomScreen = [
    const DashboardView(),
    const WishlistView(),
    const CartView(),
    const InboxView(),
    const AccountView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
