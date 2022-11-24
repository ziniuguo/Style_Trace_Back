import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/common/AppTextStyle.dart';
import 'package:style_trace_back_frontend/widgets/layer1/product_card_widgets/price_label_bar.dart';
import 'package:style_trace_back_frontend/widgets/layer1/product_card_widgets/product_title.dart';

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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(flex: 3, child: ProductTitle(brand: brand, category: category)),
      Expanded(
          flex: 3,
          child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyle.bodyTextStyle))),
      Expanded(
          flex: 4,
          child:
              PriceLabelBar(onlinePrice: onlinePrice, storePrice: storePrice)),
    ]);
  }
}
