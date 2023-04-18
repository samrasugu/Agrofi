import 'package:agrofi/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionHistoryListView extends StatefulWidget {
  const TransactionHistoryListView({super.key});

  @override
  State<TransactionHistoryListView> createState() => _TransactionHistoryListViewState();
}

class _TransactionHistoryListViewState extends State<TransactionHistoryListView> {
  var date = DateFormat.yMMMEd('en_US').format(DateTime.now());
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(10.0),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Colors.black26, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text("Farmer's Name:",
                  style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w600),),
                  SizedBox(width: 7,),
                  Text('Yaliyondwele',
                  style:  TextStyle(fontSize: 16,
                  color: GlobalVariables.primaryColor,
                  fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const Text("Diani, Sagana, Kilifi County"),
              Text(date,
              style: const TextStyle(
                color: Colors.black54
              ),)
            ],
          ),
        ),
      );
      },
    );
  }
}