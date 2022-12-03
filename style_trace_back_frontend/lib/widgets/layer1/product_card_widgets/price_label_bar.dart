import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/widgets/layer1/product_card_widgets/price_label.dart';

class PriceLabelBar extends StatelessWidget {
  final String onlinePrice;
  final String storePrice;
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
