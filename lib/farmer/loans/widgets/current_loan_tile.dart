import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/settings/services/account_services.dart';
import 'package:agrofi/models/loan.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CurrentLoanTile extends StatefulWidget {
  const CurrentLoanTile({super.key});

  @override
  State<CurrentLoanTile> createState() => _CurrentLoanTileState();
}

class _CurrentLoanTileState extends State<CurrentLoanTile> {
  // fetch current loan
  final AccountServices accountServices = AccountServices();

  Loan loan = Loan(
    id: '',
    amount: 0,
    activationData: '',
    balance: 0.0,
    dueDate: 0,
    isCurrent: false,
    issueDate: 0,
    principal: 0.0,
    requestDate: 0,
    status: '',
    userID: '',
    voucherId: '',
  );

  @override
  void initState() {
    super.initState();
    fetchCurrentLoan();
  }

  Future<void> fetchCurrentLoan() async {
    loan = await accountServices.getCurrentLoan(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(10.0),
        // height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.black26,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Text(
                  "Loan Balance:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
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

            Text.rich(
              TextSpan(
                text: "Date issued: ",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: DateFormat.yMMMd().format(
                      DateTime.fromMillisecondsSinceEpoch(loan.issueDate),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            Text.rich(
              TextSpan(
                text: "Initial Amount: ",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: "KES ${loan.principal}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

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
