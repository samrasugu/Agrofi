import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/shop/services/shop_services.dart';
import 'package:agrofi/models/product.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ShopHomeServices shopHomeServices = ShopHomeServices();
  // increment quantity
  void increaseQuantity(Product product) {
    shopHomeServices.addToCart(
      context: context,
      product: product,
    );
  }

  // decrement quantity
  void decreaseQuantity(Product product) {
    shopHomeServices.removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: GlobalVariables.primaryColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Image.network(
                    product.productImages[0],
                    fit: BoxFit.contain,
                    width: 130,
                    height: 135,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            product.productName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 5,
                          ),
                          child: Text(
                            'KES ${product.price}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 5,
                          ),
                          child: const Text(
                            'Eligible for free shipping',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 5,
                          ),
                          child: const Text(
                            'In stock',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: GlobalVariables.primaryColor,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 10.0,
                left: 10.0,
                right: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            decreaseQuantity(product);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.red,
                              size: 18,
                            ),
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 1.5,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Container(
                            height: 35,
                            width: 35,
                            alignment: Alignment.center,
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            increaseQuantity(product);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.add,
                              color: GlobalVariables.primaryColor,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
