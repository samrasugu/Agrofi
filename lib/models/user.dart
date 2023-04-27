import 'dart:convert';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String idNumber;
  final String phoneNumber;
  final String pin;
  final double latitude;
  final double longitude;
  final String userType;
  final String county;
  final String subCounty;
  final String village;
  final String landSize;
  final String tractorRegNo;
  final String tractorOwnerName;
  final String tractorOwnerId;
  final String status;
  final bool isApproved;
  bool isOnline;
  double accountBalance;
  final String deviceToken;
  final String token;
  final List<dynamic> cart;
  // final List<dynamic> supplyOrders;

  UserModel({
    required this.id, 
    required this.firstName, 
    required this.lastName, 
    required this.idNumber, 
    required this.phoneNumber, 
    required this.pin, 
    required this.latitude,
    required this.longitude,
    required this.userType,
    required this.county, 
    required this.subCounty, 
    required this.village, 
    required this.landSize, 
    required this.tractorRegNo,
    required this.tractorOwnerName,
    required this.tractorOwnerId,
    required this.status, 
    required this.isApproved,
    required this.isOnline,
    required this.accountBalance, 
    required this.deviceToken,
    required this.token,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'idNumber': idNumber,
      'phoneNumber': phoneNumber,
      'pin': pin,
      'latitude': latitude,
      'longitude': longitude,
      'userType': userType,
      'county': county,
      'subCounty': subCounty,
      'village': village,
      'landSize': landSize,
      'tractorRegNo': tractorRegNo,
      'tractorOwnerName': tractorOwnerName,
      'tractorOwnerId': tractorOwnerId,
      'status': status,
      'isApproved': isApproved,
      'isOnline': isOnline,
      'accountBalance': accountBalance,
      'deviceToken': deviceToken,
      'token': token,
      'cart': cart,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '', 
      firstName: map['firstName'] ?? '', 
      lastName: map['lastName'] ?? '', 
      idNumber: map['idNumber'] ?? '', 
      phoneNumber: map['phoneNumber'] ?? '', 
      pin: map['pin'] ?? '', 
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      userType: map['userType'] ?? '',
      county: map['county'] ?? '', 
      subCounty: map['subCounty'] ?? '', 
      village: map['village'] ?? '', 
      landSize: map['landSize'] ?? '', 
      tractorRegNo: map['tractorRegNo'] ?? '',
      tractorOwnerName: map['tractorOwnerName'] ?? '',
      tractorOwnerId: map['tractorOwnerId'] ?? '',
      status: map['status'] ?? '', 
      isApproved: map['isApproved'] ?? false,
      isOnline: map['isOnline'] ?? false,
      accountBalance: map['balance'] ?? 0.0, 
      deviceToken: map['deviceToken'] ?? '',
      token: map['token'] ?? '', 
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ), 
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? idNumber,
    String? phoneNumber,
    String? pin,
    double? latitude,
    double? longitude,
    String? userType,
    String? county,
    String? subCounty,
    String? village,
    String? landSize,
    String? tractorRegNo,
    String? tractorOwnerName,
    String? tractorOwnerId,
    String? status,
    bool? isApproved,
    bool? isOnline,
    double? accountBalance,
    String? deviceToken,
    String? token,
    List<dynamic>? cart,
  }) {
    return UserModel(
      id: id ?? this.id, 
      firstName: firstName ?? this.firstName, 
      lastName: lastName ?? this.lastName, 
      idNumber: idNumber ?? this.idNumber, 
      phoneNumber: phoneNumber ?? this.phoneNumber, 
      pin: pin ?? this.pin, 
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      userType: userType ?? this.userType,
      county: county ?? this.county, 
      subCounty: subCounty ?? this.subCounty, 
      village: village ?? this.village, 
      landSize: landSize ?? this.landSize, 
      tractorRegNo: tractorRegNo ?? this.tractorRegNo,
      tractorOwnerName: tractorOwnerName ?? this.tractorOwnerName,
      tractorOwnerId: tractorOwnerId ?? this.tractorOwnerId,
      status: status ?? this.status,
      isApproved: isApproved ?? this.isApproved,
      isOnline: isOnline ?? this.isOnline,
      accountBalance: accountBalance ?? this.accountBalance, 
      deviceToken: deviceToken ?? this.deviceToken,
      token: token ?? this.token, 
      cart: cart ?? this.cart, 
    );
  }
}