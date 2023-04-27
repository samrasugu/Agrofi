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
  Future<List<Booking>> fetchRequests({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Booking> bookingsList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/tractorOwner/requests'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      if (context.mounted) {}
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            bookingsList.add(
              Booking.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return bookingsList;
  }

  // fetch active bookings
  Future<List<Booking>> fetchBookings({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Booking> bookingsList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/tractorOwner/bookings'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      //  jsonDecode(res.body);

      // print(res.body);

      if (context.mounted) {}
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              bookingsList.add(Booking.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return bookingsList;
  }

  // change availability status - isOnline<true or false>
  void changeStatus({
    required BuildContext context,
    required bool status,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(
          "$uri/api/tractorOwner/changestatus",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'status': status,
          },
        ),
      );

      String? avail = '';
      if (status == true) {
        avail = "Online: You can receive tractor requests";
      } else {
        avail = "Offline: You cannot receive tractor requests";
      }

      if (context.mounted) {}
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Status changed to $avail");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
