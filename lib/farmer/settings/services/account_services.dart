import 'dart:ffi';

import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/auth/screens/login_screen.dart';
import 'package:agrofi/constants/error_handling.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountServices {
  // get loan balance
  Future<double> getLoanBalance({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    double balance = 0.0;
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/farmer/getloanbalance'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            balance = double.parse(res.body);
            userProvider.setLoanBalance(balance);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return balance;
  }

  // logout
  void signOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      if (context.mounted) {
        showSnackBar(context, "Logout successful");
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.routeName, (route) => false);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
