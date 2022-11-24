import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/widgets/layer3/listview_product_card.dart';

import '../common/AppIcon.dart';
import '../common/TopBar.dart';
import '../httpClient/GetRequest.dart';
import '../models/product_model.dart';

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
        '[{"brand":"Gucci","category":"Bamboo","description":"Designed by Alexandro Michele in 2015, The bag earned its name from the ancient Greek god, who was said to emulate a lavish lifestyle","onlinePrice":2950.0,"storePrice":3688.0,"imagePath":"https://i.picsum.photos/id/361/200/300.jpg?hmac=unS_7uvpA3Q-hJTvI1xNCnlhta-oC6XnWZ4Y11UpjAo"},{"brand":"Gucci","category":"Bamboo","description":"Designed by Alexandro Michele in 2015, The bag earned its name from the ancient Greek god, who was said to emulate a lavish lifestyle","onlinePrice":2950.0,"storePrice":3688.0,"imagePath":"https://i.picsum.photos/id/361/200/300.jpg?hmac=unS_7uvpA3Q-hJTvI1xNCnlhta-oC6XnWZ4Y11UpjAo"}]';

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
            child: FutureBuilder(
                future: fetchUserHistory("1004865", 3, 1),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return ListViewOfProductCard(
                        requestedData: fetchUserHistory("1004865", 3, 1));
                  }
                  return const CircularProgressIndicator();
                })));
  }
}
