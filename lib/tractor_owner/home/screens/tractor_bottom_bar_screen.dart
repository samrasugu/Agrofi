import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/tractor_owner/activity/screens/recent_activity_screen.dart';
import 'package:agrofi/tractor_owner/home/screens/tractor_home_screen.dart';
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
    const TractorOwnerHomeScreen(),
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.analytics,
            ),
            label: 'Recent activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          )
        ],
      ),
    );
  }
}
