import 'dart:convert';

import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/constants/error_handling.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddressServices {
  Future<void> changeAddress({
    required BuildContext context,
    required String village,
    required String subCounty,
    required String county,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/farmer/changeaddress'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          <String, String>{
            'village': village,
            'subCounty': subCounty,
            'county': county,
          },
        ),
      );

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            userProvider.setUser(res.body);
            showSnackBar(context, 'Address changed successfully');
            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
