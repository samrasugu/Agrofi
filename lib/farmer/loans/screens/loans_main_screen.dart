import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/home/widgets/custom_icon.dart';
import 'package:agrofi/farmer/home/widgets/custom_large_button.dart';
import 'package:agrofi/farmer/loans/screens/request_loan_screen.dart';
import 'package:agrofi/farmer/loans/widgets/current_loan_tile.dart';
import 'package:flutter/material.dart';

class LoansMainScreen extends StatefulWidget {
  static const String routeName = "/loans-screen";
  const LoansMainScreen({super.key});

  @override
  State<LoansMainScreen> createState() => _LoansMainScreenState();
}

class _LoansMainScreenState extends State<LoansMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Loans",
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: GlobalVariables.primaryColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RequestLoanScreen.routeName,
                          arguments: {},
                        );
                      },
                      child: const CustomLargeButton(
                        icon: Icons.local_atm_rounded,
                        maintext: "Request Loan",
                        subtext: 'Get a quick loan',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RequestLoanScreen.routeName,
                          arguments: {},
                        );
                      },
                      child: const CustomLargeButton(
                        icon: Icons.wallet_outlined,
                        maintext: "Repay Loan",
                        subtext: 'Pay your loan',
                      ),
                    ),
                  ],
                ),
              ),

              // booking history
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Current Loan",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const CurrentLoanTile()
            ],
          ),
        ),
      ),
    );
  }
}
