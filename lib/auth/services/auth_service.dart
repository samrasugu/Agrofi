import 'dart:convert';

import 'package:agrofi/auth/screens/user_type_selection_screen.dart';
import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/constants/error_handling.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/auth/screens/login_screen.dart';
import 'package:agrofi/farmer/home/screens/farmer_bottom_bar_screen.dart';
import 'package:agrofi/farmer/home/screens/farmer_home_screen.dart';
import 'package:agrofi/models/user.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:agrofi/tractor_owner/home/screens/tractor_bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // signup user
  Future<void> signUpUser({
    required BuildContext context,
    required String firstName,
    required String lastName,
    // required String idNumber,
    required String phoneNumber,
    required String pin,
    // required double latitude,
    // required double longitude,
    // required String useType,
    // required String county,
    // required String subCounty,
    // required String village,
    // required String landSize,
  }) async {
    try {
      UserModel user = UserModel(
        id: '',
        firstName: firstName,
        lastName: lastName,
        idNumber: '',
        phoneNumber: phoneNumber,
        pin: pin,
        latitude: 0.0,
        longitude: 0.0,
        userType: '',
        county: '',
        subCounty: '',
        village: '',
        landSize: '',
        tractorRegNo: '',
        tractorOwnerName: '',
        tractorOwnerId: '',
        status: '',
        isApproved: false,
        isOnline: false,
        accountBalance: 0,
        deviceToken: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/user/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (context.mounted) {}

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (context.mounted) {}
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
              'x-auth-token',
              jsonDecode(res.body)['token'],
            );
            if (context.mounted) {
              showSnackBar(context, "Success! your account has been created");
            }
            // redirect to user type selection screen
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                UserTypeSelectionScreen.routeName,
                (route) => false,
              );
            }
            // }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // farmer complete profile
  Future<void> farmerCompleteProfile({
    required BuildContext context,
    required String idNumber,
    required double latitude,
    required double longitude,
    required String userType,
    required String county,
    required String subCounty,
    required String village,
    required String landSize,
    required String deviceToken,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/farmerCompleteProfile'),
        body: jsonEncode({
          // 'id': user.id,
          'idNumber': idNumber,
          'latitude': latitude,
          'longitude': longitude,
          'userType': userType,
          'county': county,
          'subCounty': subCounty,
          'village': village,
          'landSize': landSize,
          'deviceToken': deviceToken,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (context.mounted) {}
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          if (context.mounted) {}
          userProvider.setUser(res.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(
            'x-auth-token',
            jsonDecode(res.body)['token'],
          );
          if (context.mounted) {
            showSnackBar(context, "Success! your profile is complete");
            Navigator.of(context).pushNamedAndRemoveUntil(
              FarmerBottomBarScreen.routeName,
              (route) => false,
            );
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  // tractor owner complete profile
  Future<void> tractorCompleteProfile({
    required BuildContext context,
    required String idNumber,
    required double latitude,
    required double longitude,
    required String userType,
    required String county,
    required String subCounty,
    required String village,
    required String tractorRegNo,
    required String tractorOwnerName,
    required String tractorOwnerId,
    required String deviceToken,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/tractorCompleteProfile'),
        body: jsonEncode({
          // 'id': user.id,
          'idNumber': idNumber,
          'latitude': latitude,
          'longitude': longitude,
          'userType': userType,
          'county': county,
          'subCounty': subCounty,
          'village': village,
          'tractorRegNo': tractorRegNo,
          'tractorOwnerName': tractorOwnerName,
          'tractorOwnerId': tractorOwnerId,
          'deviceToken': deviceToken,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (context.mounted) {}
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          if (context.mounted) {}
          userProvider.setUser(res.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(
            'x-auth-token',
            jsonDecode(res.body)['token'],
          );
          if (context.mounted) {
            // userProvider.setUser(res.body);
            showSnackBar(context, "Success! your profile is complete");
            Navigator.of(context).pushNamedAndRemoveUntil(
              TractorBottomBarScreen.routeName,
              (route) => false,
            );
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  // sign in user
  void signIn({
    required BuildContext context,
    required String phoneNumber,
    String? pin,
    required String deviceToken,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/signin'),
        body: jsonEncode({'phoneNumber': phoneNumber, 'pin': pin, 'deviceToken': deviceToken}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // print(res.body);
      if (context.mounted) {}
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (context.mounted) {}
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
              'x-auth-token',
              jsonDecode(res.body)['token'],
            );

            if (context.mounted) {
              showSnackBar(context, "Login successful");
              // check if user profile is complete..if not redirect to user type selection screen
              if (jsonDecode(res.body)['userType'] == '') {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  UserTypeSelectionScreen.routeName,
                  (route) => false,
                );
              }
              // check user type and redirect to appropriate screen
              else if (jsonDecode(res.body)['userType'] == 'farmer') {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  FarmerBottomBarScreen.routeName,
                  (route) => false,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  TractorBottomBarScreen.routeName,
                  (route) => false,
                );
              }

              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   FarmerHomeScreen.routeName,
              //   (route) => false,
              // );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  Future<void> getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // get user data
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        if (context.mounted) {}
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
