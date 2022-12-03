import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:style_trace_back_frontend/models/product_model.dart';

import '../layer2/product_card.dart';

class ProductCardOverviewScreen extends StatefulWidget {
  const ProductCardOverviewScreen({super.key});

  @override
  _ProductCardOverviewScreenState createState() =>
      _ProductCardOverviewScreenState();
}

class _ProductCardOverviewScreenState extends State<ProductCardOverviewScreen> {
  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 10;
  late List<Product> _products;
  final int _nextPageTrigger = 3;

  @override
  void initState() {
    super.initState();
    _pageNumber = 0;
    _products = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text("Blog App"), centerTitle: true,),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: buildPostsView()));
  }

  Widget buildPostsView() {
    if (_products.isEmpty) {
      if (_loading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
          ),
        );
      } else if (_error) {
        return Center(
          child: errorDialog(size: 20),
        );
      }
    }
    return ListView.builder(
      itemCount: _products.length + (_isLastPage ? 0 : 1),
      itemBuilder: (ctx, idx) {
        if (idx == _products.length - _nextPageTrigger) {
          fetchData();
        }
        if (idx == _products.length) {
          if (_error) {
            return Center(
              child: errorDialog(size: 15),
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
        final Product product = _products[idx];
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: ProductCard(
            brand: product.brand.substring(0, 5),
            category: product.category.substring(0, 5),
            description: product.description,
            onlinePrice: product.onlinePrice,
            storePrice: product.storePrice,
            imagePath: product.imagePath,
          ),
        );
      },
    );
  }

  Widget errorDialog({required double size}) {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An error occurred when fetching the posts.',
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _loading = true;
                  _error = false;
                  fetchData();
                });
              },
              child: const Text(
                "Retry",
                style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
              )),
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      final response = await get(Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_page=$_pageNumber&_limit=$_numberOfPostsPerRequest"));
      List responseList = json.decode(response.body);
      List<Product> productList = responseList
          .map((data) => Product(
              brand: data['title'],
              category: data['title'],
              description: data['body'],
              onlinePrice: data['userId'].toString(),
              storePrice: data['id'].toString(),
              imagePath:
                  "https://media.gucci.com/style/HEXE0E8E5_Center_0_0_800x800/1661274973/702721_FAAWL_9784_001_076_0000_Light-Gucci-Diana-small-tote-bag.jpg"))
          .toList();

      setState(() {
        _isLastPage = productList.length < _numberOfPostsPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _products.addAll(productList);
      });
    } catch (e) {
      _debugL("error --> $e");
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }
}

void _debugL(Object o) {
  if (kDebugMode) {
    print("product_card_screen_overview.dart: - $o");
  }
}
