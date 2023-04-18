import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentLoanTile extends StatefulWidget {
  const CurrentLoanTile({super.key});

  @override
  State<CurrentLoanTile> createState() => _CurrentLoanTileState();
}

class _CurrentLoanTileState extends State<CurrentLoanTile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 7.0,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(10.0),
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(color: Colors.black26, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Text(
                  "Loan Amount:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  "KES ${user.accountBalance}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: GlobalVariables.primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Text("Initial Amount:"),
            const Text("Date issued:"),

            // Text('${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(booking.orderedAt))}',
            // style: const TextStyle(
            //   color: Colors.black54
            // ),)
          ],
        ),
      ),
    );
  }
}
