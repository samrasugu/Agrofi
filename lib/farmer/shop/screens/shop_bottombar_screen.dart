import 'package:agrofi/farmer/shop/screens/shop_home_screen.dart';
import 'package:flutter/material.dart';

class ShopBottomBarScreen extends StatefulWidget {
  static const String routeName = "/shop-bottombar-screen";
  const ShopBottomBarScreen({super.key});

  @override
  State<ShopBottomBarScreen> createState() => _ShopBottomBarScreenState();
}

class _ShopBottomBarScreenState extends State<ShopBottomBarScreen> {
  int _page = 0;

  List<Widget> pages = [
    const ShopHomeScreen(),
    const Center(child: Text('Orders')),
    const Center(child: Text('Settings')),
    // const ShopOrdersScreen(),
    // const ShopSettingsScreen(),
  ];

  void updatePage (int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(
          left: 10,
          bottom: 1,
          right: 10,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _page,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            iconSize: 28,
            elevation: 2,
            // showSelectedLabels: false,
            // showUnselectedLabels: false,
            onTap: updatePage,
            items: const [
              // Home
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded),
              label: 'Home'
              ),
              // Orders
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),
              label: 'Orders'
              ),
              // Settings
              BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),
              label: 'Settings'
              ),
            ],
          ),
        ),
      ),
    );
  }
}