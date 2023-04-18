import 'package:agrofi/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    id: 'id', 
    firstName: '', 
    lastName: '', 
    idNumber: '', 
    phoneNumber: '', 
    pin: '', 
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

  UserModel get user => _user;

  void setUser(String user) {
    _user = UserModel.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(UserModel user) {
    _user = user;
    notifyListeners();
  }
}