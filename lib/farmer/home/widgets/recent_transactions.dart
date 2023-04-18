import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  String time = DateTime.now().hour.toString();

  var currentTime = DateFormat.Hms().format(DateTime.now());

  // DateTime now = DateTime.now();
  var date = DateFormat.yMMMEd('en_US').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 1,
          color: Colors.black26
        )
      )
    ),
        child: ListTile(
          leading: const Icon(Icons.person_2_rounded),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("KES 1200",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),),
              const SizedBox(height: 5,),
              Text(currentTime, 
              style: TextStyle(
                color: Colors.grey.shade700,
              ),)
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Kilimo Tractors",
              style: TextStyle(
                fontWeight: FontWeight.w600
              ),),
              const SizedBox(height: 5,),
              Text(date, style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700
              ),),
            ],
          ),
        ),
      );
    });
  }
}