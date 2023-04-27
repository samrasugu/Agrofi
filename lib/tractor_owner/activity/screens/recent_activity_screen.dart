import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/tractor_owner/transactions/widgets/transaction_history_list_view.dart';
import 'package:flutter/material.dart';

class RecentActivityScreen extends StatefulWidget {
  static const String routeName = "/recent-activity";
  const RecentActivityScreen({super.key});

  @override
  State<RecentActivityScreen> createState() => _RecentActivityScreenState();
}

class _RecentActivityScreenState extends State<RecentActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.primaryColor,
        title: const Text(
          "Recent acivity",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Recent bookings",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariables.primaryColor,
                    ),
                  ),
                ],
              ),
              const TransactionHistoryListView(),
              Row(
                children: const [
                  Text(
                    "Recent transactions",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariables.primaryColor,
                    ),
                  ),
                ],
              ),
              const TransactionHistoryListView(),
            ],
          ),
        ),
      ),
    );
  }
}
