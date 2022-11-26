import 'package:flutter/material.dart';
import 'package:styletraceback/src/widgets/widget_product_card/price_label.dart';

class PriceLabelBar extends StatelessWidget {
  final double onlinePrice;
  final double storePrice;
  final String onlineChannel = "Online";
  final String storeChannel = "In store";
  const PriceLabelBar(
      {super.key, required this.onlinePrice, required this.storePrice});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                PriceLabel(shoppingChannel: onlineChannel, price: onlinePrice),
                PriceLabel(
                  shoppingChannel: storeChannel,
                  price: storePrice,
                )
              ],
            )));
  }
}
