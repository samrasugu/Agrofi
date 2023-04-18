import 'dart:convert';

class TractorOwner {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? idNumber;
  final String? phoneNumber;
  final String? pin;
  final String? county;
  final String? subCounty;
  final String? village;
  final String? tractorRegNo;
  final String? tractorOwnerName;
  final String? tractorOwnerId;
  final String? status;
  late bool? isOnline;
  final int? totalEarnings;
  final String? token;

  TractorOwner({
    this.id, 
     this.firstName, 
     this.lastName, 
     this.idNumber, 
     this.phoneNumber, 
     this.pin, 
     this.county, 
     this.subCounty, 
     this.village, 
     this.tractorRegNo, 
     this.tractorOwnerName,
     this.tractorOwnerId,
     this.status, 
     this.isOnline,
     this.totalEarnings, 
     this.token,
  });

  Map<String, dynamic>? toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'idNumber': idNumber,
      'phoneNumber': phoneNumber,
      'pin': pin,
      'county': county,
      'subCounty': subCounty,
      'village': village,
      'tractorRegNo': tractorRegNo,
      'tractorOwnerName': tractorOwnerName,
      'tractorOwnerId': tractorOwnerId,
      'status': status,
      'isOnline': isOnline,
      'totalEarnings': totalEarnings,
      'token': token,
    };
  }

  factory TractorOwner.fromMap(Map<String, dynamic>? map) {
    return TractorOwner(
      id: map?['_id'] ?? '', 
      firstName: map?['firstName'] ?? '', 
      lastName: map?['lastName'] ?? '', 
      idNumber: map?['idNumber'] ?? '', 
      phoneNumber: map?['phoneNumber'] ?? '', 
      pin: map?['pin'] ?? '', 
      county: map?['county'] ?? '', 
      subCounty: map?['subCounty'] ?? '', 
      village: map?['village'] ?? '', 
      tractorRegNo: map?['tractorRegNo'] ?? '', 
      tractorOwnerName: map?['tractorOwnerName'] ?? '',
      tractorOwnerId: map?['tractorOwnerId'] ?? '',
      status: map?['status'] ?? '', 
      isOnline: map?['isOnline'] ?? false,
      totalEarnings: map?['totalEarnings'] ?? 0, 
      token: map?['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  // factory TractorOwner.fromJson(String source) => TractorOwner.fromMap(json.decode(source));

  TractorOwner copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? idNumber,
    String? phoneNumber,
    String? pin,
    String? county,
    String? subCounty,
    String? village,
    String? tractorRegNo,
    String? tractorOwnerName,
    String? tractorOwnerId,
    String? status,
    bool? isOnline,
    int? totalEarnings,
    String? token,
  }) {
    return TractorOwner(
      id: id ?? this.id, 
      firstName: firstName ?? this.firstName, 
      lastName: lastName ?? this.lastName, 
      idNumber: idNumber ?? this.idNumber, 
      phoneNumber: phoneNumber ?? this.phoneNumber, 
      pin: pin ?? this.pin, 
      county: county ?? this.county, 
      subCounty: subCounty ?? this.subCounty, 
      village: village ?? this.village, 
      tractorRegNo: tractorRegNo ?? this.tractorRegNo, 
      tractorOwnerName: tractorOwnerName ?? this.tractorOwnerName, 
      tractorOwnerId: tractorOwnerId ?? this.tractorOwnerId, 
      status: status ?? this.status, 
      isOnline: isOnline ?? this.isOnline,
      totalEarnings: totalEarnings ?? this.totalEarnings, 
      token: token ?? this.token, 
    );
  }
}