import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/tractor_owner/activity/screens/recent_activity_screen.dart';
import 'package:agrofi/tractor_owner/home/screens/home_screen.dart';
import 'package:agrofi/tractor_owner/settings/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class TractorBottomBarScreen extends StatefulWidget {
  static const String routeName = "/tractor-bottom-bar-screen";
  const TractorBottomBarScreen({super.key});

  @override
  State<TractorBottomBarScreen> createState() => _TractorBottomBarScreenState();
}

class _TractorBottomBarScreenState extends State<TractorBottomBarScreen> {
  int _page = 0;

  List<Widget> pages = [
    const HomeScreen(),
    // const TransactionsHomeScreen(),
    const RecentActivityScreen(),
    const SettingsScreen()
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackGround,
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
                  selectedItemColor: GlobalVariables.primaryColor,
                  unselectedItemColor: Colors.black,
                  backgroundColor: GlobalVariables.greyBackGround,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 28,
                  elevation: 2,
                  // showSelectedLabels: false,
                  // showUnselectedLabels: false,
                  onTap: updatePage,
                  items: const [
                    // Home
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_rounded), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.access_time),
                        label: 'Recent activity'),
                    // BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined),
                    // label: 'Transactions'
                    // ),
                    // BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined),
                    // label: ''
                    // ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings')
                  ]),
            )));
  }
}
