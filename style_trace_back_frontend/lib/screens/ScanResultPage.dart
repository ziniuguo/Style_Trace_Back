import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/widgets/layer3/listview_product_card.dart';

import '../common/AppIcon.dart';
import '../common/TopBar.dart';
import '../httpClient/GetRequest.dart';
import '../models/product_model.dart';
import '../widgets/infScroller/product_card_screen_overview.dart';

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const ProductCardOverviewScreen(),
      ),
    );
  }
}
