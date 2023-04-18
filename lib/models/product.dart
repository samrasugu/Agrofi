import 'dart:convert';

class Product {
  final String id;
  final String productName;
  final double price;
  final double salePrice;
  final String description;
  final String category;
  final String storeID;
  final double quantity;
  final List<String> productImages;
  // final List<Rating>? rating;
  // final bool isFavorite;

  Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.salePrice,
    required this.description,
    required this.category,
    required this.storeID,
    required this.quantity,
    required this.productImages,
    // this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'salePrice': salePrice,
      'description': description,
      'category': category,
      'storeID': storeID,
      'quantity': quantity,
      'productImages': productImages,
      // 'rating': rating,
      // 'isFavorite': isFavorite,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] ?? '',
      productName: map['productName'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      salePrice: map['salePrice']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      storeID: map['storeID'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      productImages: List<String>.from(map['productImages']),
      // rating: map['rating'],
      // isFavorite: map['isFavorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}