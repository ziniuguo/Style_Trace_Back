import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/widgets/product_card_widgets/price_label.dart';

class PriceLabelBar extends StatelessWidget {
  final double onlinePrice;
  final double storePrice;
  final String onlineChannel = "Online";
  final String storeChannel = "In store";
  const PriceLabelBar(
      {super.key, required this.onlinePrice, required this.storePrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child:
                PriceLabel(shoppingChannel: onlineChannel, price: onlinePrice)),
        Expanded(
            flex: 5,
            child: PriceLabel(
              shoppingChannel: storeChannel,
              price: storePrice,
            ))
      ],
    );
  }
}
