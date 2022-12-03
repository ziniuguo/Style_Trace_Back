import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/models/product_model.dart';
import '../layer2/product_card.dart';

class ListViewOfProductCard extends StatelessWidget {
  final List<Product> requestedData;
  const ListViewOfProductCard({super.key, required this.requestedData});

  @override
  Widget build(BuildContext context) {
    List<Product> allRecords = requestedData;
    return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          ...allRecords.map(
            (record) => ProductCard(
              brand: record.brand,
              category: record.category,
              description: record.description,
              onlinePrice: record.onlinePrice,
              storePrice: record.storePrice,
              imagePath: record.imagePath,
            ),
          )
        ]);
  }
}
