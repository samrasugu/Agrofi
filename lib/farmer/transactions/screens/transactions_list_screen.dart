import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/home/widgets/recent_transactions.dart';
import 'package:flutter/material.dart';

class TransactionsListScreen extends StatefulWidget {
  static const String routeName = "/transactions-list-screen";
  const TransactionsListScreen({super.key});

  @override
  State<TransactionsListScreen> createState() => _TransactionsListScreenState();
}

class _TransactionsListScreenState extends State<TransactionsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction History",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: GlobalVariables.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          child: Column(
            children: const [
              RecentTransactions(),
            ],
          ),
        ),
      ),
    );
  }
}
