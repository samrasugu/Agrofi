import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/home/screens/farmer_home_screen.dart';
import 'package:agrofi/farmer/settings/screens/settings_screen.dart';
import 'package:agrofi/farmer/loans/screens/loans_main_screen.dart';
import 'package:agrofi/farmer/shop/screens/shop_home_screen.dart';
import 'package:flutter/material.dart';

class FarmerBottomBarScreen extends StatefulWidget {
  static const String routeName = "/bottom-bar-screen";
  const FarmerBottomBarScreen({super.key});

  @override
  State<FarmerBottomBarScreen> createState() => _FarmerBottomBarScreenState();
}

class _FarmerBottomBarScreenState extends State<FarmerBottomBarScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const FarmerHomeScreen(),
    const ShopHomeScreen(),
    const LoansMainScreen(),
    const SettingsScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.primaryColor,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        elevation: 20,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        onTap: updatePage,
        items: const [
          // Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_rounded),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Loans',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.all_inbox_outlined),
          //   label: 'Orders',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
      ),
    );
  }
}
