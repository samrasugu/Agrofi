import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/shop/screens/cart_screen.dart';
import 'package:agrofi/farmer/shop/screens/product_details_screen.dart';
import 'package:agrofi/farmer/shop/services/shop_services.dart';
import 'package:agrofi/models/product.dart';
import 'package:agrofi/models/store.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:provider/provider.dart';

class StoreDetailsScreen extends StatefulWidget {
  static const String routeName = "/store-details-screen";
  final Store store;
  const StoreDetailsScreen({super.key, required this.store});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  List<Product>? productList;

  final ShopHomeServices shopHomeServices = ShopHomeServices();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    productList = await shopHomeServices.fetchProductsByStoreId(
      context: context,
      storeId: widget.store.id,
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 7.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  CartScreen.routeName,
                  arguments: {},
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 17.0,
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
          )
        ],
        backgroundColor: GlobalVariables.backGrooundColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: GlobalVariables.backGrooundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.pexels.com/photos/4483610/pexels-photo-4483610.jpeg?auto=compress&cs=tinysrgb&w=600',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 10.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: GlobalVariables.backGrooundColor,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        size: 20,
                        color: GlobalVariables.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.store.businessName,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${widget.store.areaName}, ${widget.store.subCounty}, ${widget.store.county}',
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 17,
                    ),
                  ),
                  const Text(
                    'Open until 6:00 PM',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 17,
                    ),
                  ),
                  // products list
                  const SizedBox(height: 20),
                  // const SizedBox(height: 10),
                  // products listview
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            productList == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : productList!.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: const BoxDecoration(
                              color: GlobalVariables.greyBackGround,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "This store has no products yet",
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemCount: productList!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.85,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final product = productList![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  ProductDetailsScreen.routeName,
                                  arguments: productList![index],
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10.0,
                                ),
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.withOpacity(0.5),
                                  //     spreadRadius: 1,
                                  //     blurRadius: 7,
                                  //     offset: const Offset(0, 3),
                                  //   ),
                                  // ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 125,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        // borderRadius: BorderRadius.only(
                                        //   topLeft: Radius.circular(10),
                                        //   topRight: Radius.circular(10),
                                        // ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'https://images.pexels.com/photos/4483610/pexels-photo-4483610.jpeg?auto=compress&cs=tinysrgb&w=600',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: Text(
                                        product.productName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(height: 6),
                                    product.salePrice != 0
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                              left: 1.0,
                                            ),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'KES ${product.salePrice}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black87,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '  ',
                                                  ),
                                                  TextSpan(
                                                    text: product.price
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: GlobalVariables
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'KES ${product.price}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black87,
                                                      // decoration: TextDecoration.lineThrough,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
