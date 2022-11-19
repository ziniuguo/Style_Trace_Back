import 'package:flutter/material.dart';

class Product {
  String brand;
  String category;
  String description;
  double onlinePrice;
  double storePrice;
  String imagePath;

  Product(
      {required this.brand,
      required this.category,
      required this.description,
      required this.onlinePrice,
      required this.storePrice,
      required this.imagePath});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        brand: json["brand"] as String,
        category: json["category"] as String,
        description: json["description"] as String,
        onlinePrice: json["onlinePrice"] as double,
        storePrice: json["storePrice"] as double,
        imagePath: json["imagePath"] as String);
  }
}
