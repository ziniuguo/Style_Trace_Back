import 'package:flutter/material.dart';
import 'package:styletraceback/src/widgets/widget_product_card/price_label_bar.dart';
import 'package:styletraceback/src/widgets/widget_product_card/product_title.dart';

class ProductInfo extends StatelessWidget {
  final String brand;
  final String category;
  final String description;
  final double onlinePrice;
  final double storePrice;
  const ProductInfo(
      {super.key,
      required this.brand,
      required this.category,
      required this.description,
      required this.onlinePrice,
      required this.storePrice});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              ProductTitle(brand: brand, category: category),
              Text(description),
              PriceLabelBar(onlinePrice: onlinePrice, storePrice: storePrice)
            ])));
  }
}
