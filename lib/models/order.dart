import 'dart:convert';

import 'package:agrofi/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String userID;
  final String storeID;
  final int status;
  final double totalAmount;
  final int totalItems;
  final int orderedAt;

  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.userID,
    required this.storeID,
    required this.status,
    required this.totalAmount,
    required this.totalItems,
    required this.orderedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'userID': userID,
      'storeID': storeID,
      'status': status,
      'totalAmount': totalAmount,
      'totalItems': totalItems,
      'orderedAt': orderedAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
        map['products']?.map(
          (x) => Product.fromMap(
            x['product'],
          ),
        ),
      ),
      quantity: List<int>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
      userID: map['userID'] ?? '',
      storeID: map['storeID'] ?? '',
      status: map['status'] ?? 0,
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
      totalItems: map['totalItems'] ?? 0,
      orderedAt: map['orderedAt'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}