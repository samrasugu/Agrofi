import 'package:agrofi/tractor_owner/transactions/widgets/transaction_history_list_view.dart';
import 'package:flutter/material.dart';

class TransactionsHomeScreen extends StatefulWidget {
  static const String routeName = "/transactions-home";
  const TransactionsHomeScreen({super.key});

  @override
  State<TransactionsHomeScreen> createState() => _TransactionsHomeScreenState();
}

class _TransactionsHomeScreenState extends State<TransactionsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions",
        style: TextStyle(fontSize: 18),),
        centerTitle: true,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: TransactionHistoryListView(),
          ),
        ),
      ),
    );
  }
}