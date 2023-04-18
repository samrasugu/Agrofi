import 'dart:convert';

class Store {
  final String id;
  final String businessName;
  final String businessEmail;
  final bool isApproved;
  final String storeNumber;
  // ignore: todo
  // final String website; //TODO: to be added
  // final String logo;
  // final String cover;
  // final String description;
  final String businessPhone;
  final String county;
  final String subCounty;
  final String areaName;
  final bool isOnline;

  Store({
    required this.id,
    required this.businessName,
    required this.businessEmail,
    required this.isApproved,
    required this.storeNumber,
    required this.businessPhone,
    required this.county,
    required this.subCounty,
    required this.areaName,
    required this.isOnline,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessName': businessName,
      'businessEmail': businessEmail,
      'isApproved': isApproved,
      'storeNumber': storeNumber,
      // 'website': website,
      // 'logo': logo,
      // 'cover': cover,
      // 'description': description,
      'businessPhone': businessPhone,
      'county': county,
      'subCounty': subCounty,
      'areaName': areaName,
      'isOnline': isOnline,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['_id'] ?? '',
      businessName: map['businessName'] ?? '',
      businessEmail: map['businessEmail'] ?? '',
      isApproved: map['isApproved'] ?? false,
      storeNumber: map['storeNumber'] ?? '',
      // website: map['website'],
      // logo: map['logo'],
      // cover: map['cover'],
      // description: map['description'],
      businessPhone: map['businessPhone'] ?? '',
      county: map['county'] ?? '',
      subCounty: map['subCounty'] ?? '',
      areaName: map['areaName'] ?? '',
      isOnline: map['isOnline'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());
  factory Store.fromJson(String source) => Store.fromMap(json.decode(source));

  Store copyWith({
    String? id,
    String? businessName,
    String? businessEmail,
    bool? isApproved,
    String? storeNumber,
    // String? website,
    // String? logo,
    // String? cover,
    // String? description,
    String? businessPhone,
    String? county,
    String? subCounty,
    String? areaName,
    bool? isOnline,
  }) {
    return Store(
      id: id ?? this.id,
      businessName: businessName ?? this.businessName,
      businessEmail: businessEmail ?? this.businessEmail,
      isApproved: isApproved ?? this.isApproved,
      storeNumber: storeNumber ?? this.storeNumber,
      // website: website ?? this.website,
      // logo: logo ?? this.logo,
      // cover: cover ?? this.cover,
      // description: description ?? this.description,
      businessPhone: businessPhone ?? this.businessPhone,
      county: county ?? this.county,
      subCounty: subCounty ?? this.subCounty,
      areaName: areaName ?? this.areaName,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
