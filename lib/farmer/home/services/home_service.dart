import 'dart:convert';

import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/constants/error_handling.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/models/booking.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeService {
  // fetch bookings
  Future<List<Booking>> fetchBookings({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Booking> bookingList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/farmer/getbookings'),
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
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              bookingList.add(
                Booking.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return bookingList;
  }

  // fetch pending bookings
  Future<List<Booking>> fetchPendingBookings({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Booking> bookingList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/farmer/fetchPendingBookings'),
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
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              bookingList.add(
                Booking.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return bookingList;
  }

  // fetch bookings
  Future<List<Booking>> fetchActiveBookings({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Booking> bookingList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/farmer/fetchActiveBookings'),
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
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              bookingList.add(
                Booking.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return bookingList;
  }
}
