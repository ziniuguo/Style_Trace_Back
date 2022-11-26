import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  final String brand;
  final String category;
  final String separator = "·";
  const ProductTitle({super.key, required this.brand, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [Text(brand), Text(separator), Text(category)],
      ),
    );
  }
}
