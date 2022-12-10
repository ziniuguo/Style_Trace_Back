import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/widgets/infScroller/product_card_screen_overview.dart';

void main() {
  runApp(const MyAppMockup());
}

class MyAppMockup extends StatelessWidget {
  const MyAppMockup({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProductCardOverviewScreen(),
    );
  }
}
