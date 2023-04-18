import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubTotal extends StatefulWidget {
  const CartSubTotal({super.key});

  @override
  State<CartSubTotal> createState() => _CartSubTotalState();
}

class _CartSubTotalState extends State<CartSubTotal> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    // for (var i = 0; i < user.cart.length; i++) {
      // sum += user.cart[i]['price'] as int;
    // }
    user.cart.map((e) => sum += e['quantity'] * e['product']['price'] as int).toList();
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Subtotal',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'KES. $sum',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}