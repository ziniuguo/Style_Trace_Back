import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/widgets/layer3/listview_product_card.dart';

import '../common/AppIcon.dart';
import '../common/TopBar.dart';
import '../httpClient/GetRequest.dart';

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
                // future: uploadScanningImage("1004865", ""),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.hasData) {
                      return ListViewOfProductCard(
                          requestedData: snapshot.data);
                    }
                  }
                  return const CircularProgressIndicator();
                })));
  }
}
