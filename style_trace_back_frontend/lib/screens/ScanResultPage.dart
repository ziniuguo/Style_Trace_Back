import 'dart:convert';
import 'package:flutter/material.dart';

import '../common/AppIcon.dart';
import '../common/TopBar.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class ScanResultPage extends StatefulWidget {
  const ScanResultPage({
    Key? key,
  }) : super(key: key);

  @override
  _ScanResultPageState createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  @override
  Widget build(BuildContext context) {
    String jsonDict =
        '[{"brand":"Gucci","category":"Bamboo","description":"Designed by Alexandro Michele in 2015, The bag earned its name from the ancient Greek god, who was said to emulate a lavish lifestyle","onlinePrice":2950.0,"storePrice":3688.0,"imagePath":"https://i.picsum.photos/id/361/200/300.jpg?hmac=unS_7uvpA3Q-hJTvI1xNCnlhta-oC6XnWZ4Y11UpjAo"}]';

    List<dynamic> recordsList = jsonDecode(jsonDict);
    List<Product> allRecords =
        recordsList.map((item) => Product.fromJson(item)).toList();

    return Scaffold(
      appBar: topBar(
        pageName: "Scan Result",
        leadingIcon: AppIcon.topBarBack,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(5.0),
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
              ])),
    );
  }
}
