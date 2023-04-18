import 'dart:convert';

import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/constants/error_handling.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/models/booking.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BookingService {
  void confirmBooking({
    required BuildContext context,
    required Booking booking,
  }) async {
    // print(booking.id);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/tractorOwner/confirmrequest"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'orderId': booking.id
        })
      );

      if (context.mounted) {
        
      }
      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: () {
          showSnackBar(context, "Success! You have confirmed the request");
        }
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  } 
}