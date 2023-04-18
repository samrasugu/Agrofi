import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  // logout
  void signOut (BuildContext context) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      if (context.mounted) {
        showSnackBar(context, "Logout successful");
        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}