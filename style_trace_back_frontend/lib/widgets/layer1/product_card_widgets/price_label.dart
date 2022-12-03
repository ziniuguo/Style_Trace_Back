import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/common/AppColor.dart';
import 'package:style_trace_back_frontend/common/AppTextStyle.dart';

class PriceLabel extends StatelessWidget {
  final String price;
  final String shoppingChannel;
  const PriceLabel(
      {super.key, required this.shoppingChannel, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      const Icon(Icons.local_offer_outlined, color: AppColor.black, size: 18.0),
      Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(shoppingChannel, style: AppTextStyle.captionTextStyle),
                Text("S\$${price.toString()}",
                    style: AppTextStyle.priceTextStyle)
              ]))
    ]);
  }
}
