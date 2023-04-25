import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/settings/services/account_services.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoanBalance extends StatefulWidget {
  const LoanBalance({super.key});

  @override
  State<LoanBalance> createState() => _LoanBalanceState();
}

class _LoanBalanceState extends State<LoanBalance> {
  double? loanbalance;

  // fetch loan balance
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchLoanBalance();
  }

  Future<void> fetchLoanBalance() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final response = await accountServices.getLoanBalance(context: context);
    setState(() {
      loanbalance = response;
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.2,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: GlobalVariables.primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Loan balance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "KES ${user.accountBalance}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
