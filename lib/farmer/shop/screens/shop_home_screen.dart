import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/shop/screens/cart_screen.dart';
import 'package:agrofi/farmer/shop/widgets/stores_list.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as Badge;

class ShopHomeScreen extends StatefulWidget {
  static const String routeName = "/shop-home-screen";
  const ShopHomeScreen({super.key});

  @override
  State<ShopHomeScreen> createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: GlobalVariables.backGrooundColor,
            ),
          ),
          elevation: 1.0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 20,
                color: Colors.black,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 2,
                  ),
                  child: Text(
                    "Delivery to ${user.village}, ${user.subCounty}, ${user.county}",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 5,
                  top: 2,
                  right: 1,
                ),
                child: Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    CartScreen.routeName,
                    arguments: {},
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: GlobalVariables.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Badge.Badge(
                    badgeContent: Text(user.cart.length.toString()),
                    position: Badge.BadgePosition.topEnd(),
                    badgeStyle: const Badge.BadgeStyle(
                      badgeColor: Colors.white,
                      elevation: 4,
                      padding: EdgeInsets.all(4),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_rounded,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: GlobalVariables.backGrooundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "Stores Near You",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            // ShopCarousel(),
            // SizedBox(
            //   height: 10,
            // ),
            StoresList()
          ],
        ),
      ),
    );
  }
}
