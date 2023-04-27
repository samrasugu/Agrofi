import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/shop/screens/checkout_screen.dart';
import 'package:agrofi/farmer/shop/services/shop_services.dart';
import 'package:agrofi/farmer/shop/widgets/cart_product.dart';
import 'package:agrofi/farmer/shop/widgets/cart_subtotal.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ShopHomeServices shopHomeServices = ShopHomeServices();

  // clear cart
  void clearCart() {
    shopHomeServices.clearCart(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: GlobalVariables.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const AddressBox(),
            user.cart.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 70.0, horizontal: 20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/icons/empty-shopping-cart.json',
                            height: 200,
                            width: 200,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Add items to your cart',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Start shopping by adding items from a store to your cart',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.5,
                                50,
                              ),
                              backgroundColor: GlobalVariables.primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    10,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Shop Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: CartSubTotal(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: CustomButton(
                            text: "Proceed to buy ${user.cart.length} item(s)",
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                CheckoutScreen.routeName,
                                arguments: {},
                              );
                            },
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: Colors.black12.withOpacity(0.08),
                          height: 1,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListView.builder(
                            itemCount: user.cart.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CartProduct(
                                index: index,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            clearCart();
                          },
                          child: const Text(
                            'Clear Cart',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
