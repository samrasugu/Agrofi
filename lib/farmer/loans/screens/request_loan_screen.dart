import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/loans/services/loan_service.dart';
import 'package:flutter/material.dart';

class RequestLoanScreen extends StatefulWidget {
  static const String routeName = '/request-loan';
  const RequestLoanScreen({super.key});

  @override
  State<RequestLoanScreen> createState() => _RequestLoanScreenState();
}

class _RequestLoanScreenState extends State<RequestLoanScreen> {
  bool loanConsent = false;
  bool termsConsent = false;

  final LoanService loanService = LoanService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Loan request",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: GlobalVariables.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Conditions for award of loan:",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    "1. You must have been approved, verified and have correct information.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "2. You are required to pay an initial fee which will contribute towards and will be added to your allocated loan.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(
                    height: 7,
                  ),
                   // consent checkboxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("I agree to terms and conditions"),
                      Checkbox(
                        value: termsConsent,
                        onChanged: (value) {
                          setState(() {
                            termsConsent = value!;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  CustomButton(
                    text: "Request for loan",
                    color: GlobalVariables.primaryColor,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Confirm Loan Request'),
                          content: const Text(
                            'You will receive a notification. Enter your PIN to pay the initial fee',
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text(
                                "Cancel",
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (termsConsent != true) {
                                  Navigator.of(ctx).pop();
                                  showSnackBar(
                                    context,
                                    "You need to agree to terms and conditions",
                                  );
                                } else {
                                  Navigator.of(ctx).pop();
                                  loanService.requestLoan(context: context);
                                }
                              },
                              child: const Text(
                                "Confirm",
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
