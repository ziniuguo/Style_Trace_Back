import 'dart:convert';
import 'dart:developer';

import '../common/Config.dart';
import '../models/product_model.dart';
import 'package:dio/dio.dart';

Future<List<Product>> fetchUserHistory(
    String userId, int toHistoryIndex, int fromHistoryIndex) async {
  final Dio dio = Dio();
  const String baseUrl = Config.baseUrl;
  const String productInfoURL = "$baseUrl/usrhistory";
  Response res = await dio.get(productInfoURL, queryParameters: {
    "userid": userId,
    "last": toHistoryIndex,
    "first": fromHistoryIndex
  });

  Iterable recordsList = jsonDecode(res.data);
  List<Product> allRecords =
      List<Product>.from(recordsList.map((item) => Product.fromJson(item)));
  return allRecords;
}
