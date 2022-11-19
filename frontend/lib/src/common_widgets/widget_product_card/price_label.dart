import 'package:flutter/material.dart';

class PriceLabel extends StatelessWidget {
  final double price;
  final String shoppingChannel;
  const PriceLabel(
      {super.key, required this.shoppingChannel, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(children: <Widget>[
                  const Icon(Icons.local_offer_outlined, color: Colors.black),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(children: <Widget>[
                        Text(shoppingChannel),
                        Text("S\$${price.toString()}")
                      ]))
                ]))));
  }
}
