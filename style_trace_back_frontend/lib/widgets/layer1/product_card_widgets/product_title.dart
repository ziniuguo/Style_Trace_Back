import 'package:flutter/material.dart';
import '../../../common/AppTextStyle.dart';

class ProductTitle extends StatelessWidget {
  final String brand;
  final String category;
  final String separator = "·";
  const ProductTitle({super.key, required this.brand, required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(brand, style: AppTextStyle.productBrandTextStyle),
        Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child:
                Text(separator, style: AppTextStyle.productCategoryTextStyle)),
        Text(category, style: AppTextStyle.productCategoryTextStyle),
      ],
    );
  }
}
