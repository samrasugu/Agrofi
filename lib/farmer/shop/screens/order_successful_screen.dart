import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/home/screens/farmer_bottom_bar_screen.dart';
import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  static const String routeName = "/order-successful";
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Successful",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: GlobalVariables.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Text(
                  "Your order has been placed successfully.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Icon(
                  Icons.check_circle,
                  color: GlobalVariables.primaryColor,
                  size: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "You will receive a confirmation message shortly.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Continue',
                  color: GlobalVariables.primaryColor,
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      FarmerBottomBarScreen.routeName,
                      (route) => false,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
