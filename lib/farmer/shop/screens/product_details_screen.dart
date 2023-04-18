import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/common/widgets/custom_disabled_button.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/shop/screens/cart_screen.dart';
import 'package:agrofi/farmer/shop/services/shop_services.dart';
import 'package:agrofi/models/product.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ShopHomeServices shopHomeServices = ShopHomeServices();
  // add product to cart
  void addToCart() {
    shopHomeServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Product Details',
              style: TextStyle(fontSize: 18),
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
                  horizontal: 17.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: GlobalVariables.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: badge.Badge(
                  badgeContent: Text(user.cart.length.toString()),
                  position: badge.BadgePosition.topEnd(),
                  badgeStyle: const badge.BadgeStyle(
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
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: GlobalVariables.backGrooundColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 10.0,
              ),
              child: Row(
                children: const [
                  Text(
                    "Product rating star",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 5.0,
              ),
              child: Text(
                widget.product.productName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.productImages.map((i) {
                return Builder(
                  builder: (BuildContext context) => Image.network(
                    i,
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.product.salePrice != 0
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Price: ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'KES ${widget.product.price} ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: GlobalVariables.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: 'KES ${widget.product.salePrice} ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Price: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'KES ${widget.product.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            widget.product.salePrice != 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Text(
                      '${(widget.product.price - widget.product.salePrice) / 100} % off',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // color: GlobalVariables.primaryColor,
                        color: Colors.deepOrange,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 1,
            ),
            widget.product.quantity == 0
                ? const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 5.0,
                    ),
                    child: Text(
                      'Out of stock',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  )
                : widget.product.quantity < 20
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 5.0,
                        ),
                        child: Text(
                          'Only ${widget.product.quantity.floor()} item(s) left',
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                          ),
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 5.0,
                        ),
                        child: Text(
                          'In stock',
                          style: TextStyle(
                            color: GlobalVariables.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
            Container(
              height: 1,
              color: Colors.black12,
            ),
            // check if current product in cart is of another storeID then disabled the 'Add To Cart' button
            user.cart.isNotEmpty &&
                    user.cart[0]['product']['storeID'] != widget.product.storeID
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: CustomDiabledButton(
                      text: 'Add To Cart',
                      onTap: () {},
                      color: Colors.grey.shade100,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: CustomButton(
                      text: 'Add to Cart',
                      color: GlobalVariables.primaryColor,
                      onTap: () {
                        addToCart();
                      },
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(
                8.0,
              ),
              child: Text(
                "Product description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Text(
                widget.product.description,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              child: Text(
                'Rate the product',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
