import 'package:agrofi/tractor_owner/transactions/widgets/transaction_history_list_view.dart';
import 'package:flutter/material.dart';

class BookingsListScreen extends StatefulWidget {
  static const String routeName = "/bookings-history";
  const BookingsListScreen({super.key});

  @override
  State<BookingsListScreen> createState() => _BookingsListScreenState();
}

class _BookingsListScreenState extends State<BookingsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking history",
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