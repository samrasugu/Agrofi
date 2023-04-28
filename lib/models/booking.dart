import 'dart:convert';

import 'package:agrofi/models/tractorowner.dart';
import 'package:agrofi/models/user.dart';

class Booking {
  final String id;
  final String trackingID;
  final UserModel? farmer;
  final TractorOwner? tractorOwner;
  final int orderedAt;
  final int status;
  final String dateExpected;
  final String dateCompleted;


  Booking({
    required this.id, 
    required this.trackingID,
    required this.farmer, 
    this.tractorOwner, 
    required this.orderedAt, 
    required this.status, 
    required this.dateExpected, 
    required this.dateCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tractorOwner': tractorOwner,
      'orderedAt': orderedAt,
      'status': status,
      'dateExpected': dateExpected,
      'dateCompleted': dateCompleted
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['_id'] ?? '', 
      trackingID: map['trackingId'] ?? '',
      farmer: UserModel.fromMap(map['farmer']),
      tractorOwner: TractorOwner.fromMap(map['tractorOwner']), 
      orderedAt: map['orderedAt'] ?? 0, 
      status: map['status'] ?? 0, 
      dateExpected: map['dateExpected'] ?? '', 
      dateCompleted: map['dateCompleted'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) => Booking.fromMap(json.decode(source));

  Booking copyWith({
    String? id,
    String? trackingID,
    UserModel? farmer,
    TractorOwner? tractorOwner,
    int? orderedAt,
    int? status,
    String? dateExpected,
    String? dateCompleted,
  }) {
    return Booking(
      id: id ?? this.id, 
      trackingID: trackingID ?? this.trackingID,
      farmer: farmer ?? this.farmer, 
      tractorOwner: tractorOwner ?? this.tractorOwner, 
      orderedAt: orderedAt ?? this.orderedAt, 
      status: status ?? this.status, 
      dateExpected: dateExpected ?? this.dateExpected, 
      dateCompleted: dateCompleted ?? this.dateCompleted
    );
  }
}