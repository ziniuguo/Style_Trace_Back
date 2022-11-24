import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/models/product_model.dart';
import '../layer2/product_card.dart';

class ListViewOfProductCard extends StatelessWidget {
  final Future<List<Product>> requestedData;
  const ListViewOfProductCard({required this.requestedData});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: requestedData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Product> allRecords = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            return ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10.0),
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
          return const CircularProgressIndicator();
        });
  }
}
