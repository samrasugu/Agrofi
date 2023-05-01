import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/shop/widgets/order_list_tile.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = "/orders-screen";
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(fontSize: 16),
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
          children: const [
            SizedBox(
              height: 10,
            ),
            OrderListTile(),
          ],
        ),
      ),
    );
  }
}
