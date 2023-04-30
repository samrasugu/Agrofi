import 'dart:convert';

import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/auth/screens/login_screen.dart';
import 'package:agrofi/constants/error_handling.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/models/loan.dart';
import 'package:agrofi/models/transaction.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountServices {
  // get loan balance
  Future<Loan> getCurrentLoan({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Loan loan = Loan(
      balance: 0.0,
      activationData: '',
      amount: 0.0,
      dueDate: 0,
      id: '',
      isCurrent: false,
      issueDate: 0,
      principal: 0.0,
      status: '',
      requestDate: 0,
      userID: '',
      voucherId: '',
    );
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/farmer/getloanbalance'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // balance = double.parse(res.body);
              loan = Loan.fromJson(
                jsonEncode(
                  jsonDecode(
                    res.body,
                  ),
                ),
              );
            userProvider.setLoanBalance(loan.balance!);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return loan;
  }

  // fetch recent transactions
  Future<List<Transaction>> fetchRecentTransactions({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Transaction> transactions = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/farmer/fetchMyTransactions'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              transactions.add(
                Transaction.fromJson(
                  jsonEncode(
                    jsonDecode(
                      res.body,
                    )[i],
                  ),
                ),
              );
            }
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return transactions;
  }

  // logout
  void signOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString(
        'x-auth-token',
        '',
      );
      if (context.mounted) {
        showSnackBar(context, "Logout successful");
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
