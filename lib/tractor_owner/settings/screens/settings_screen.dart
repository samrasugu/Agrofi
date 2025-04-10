import 'package:agrofi/common/widgets/custom_list_tile.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/transactions/screens/transactions_list_screen.dart';
import 'package:agrofi/tractor_owner/settings/screens/account_screen.dart';
import 'package:agrofi/tractor_owner/settings/services/account_services.dart';
// import 'package:agrofi/tractor_owner/transactions/screens/transactions_home_screen.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrofi/common/screens/bookings_list_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "/settings-screen";
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: GlobalVariables.primaryColor,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // user profile
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AccountScreen.routeName,
                      arguments: {},
                    );
                  },
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/icons/usericon.png'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          // const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              color: Colors.black12,
              height: 1,
            ),
          ),

          // setting list tiles
          Column(
            children: [
              CustomListTile(
                leadingIcon: Icons.list,
                trailingIcon: Icons.arrow_forward_ios_rounded,
                title: "Bookings history",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    BookingsListScreen.routeName,
                  );
                },
              ),
              CustomListTile(
                leadingIcon: Icons.list,
                trailingIcon: Icons.arrow_forward_ios_rounded,
                title: "Transaction history",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TransactionsListScreen.routeName,
                    arguments: {},
                  );
                },
              ),
              CustomListTile(
                leadingIcon: Icons.help_outline_rounded,
                trailingIcon: Icons.arrow_forward_ios_rounded,
                title: "Help",
                onTap: () {},
              ),
              CustomListTile(
                leadingIcon: Icons.logout_rounded,
                trailingIcon: Icons.arrow_forward_ios_rounded,
                title: "Logout",
                onTap: () {
                  AccountServices().signOut(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
