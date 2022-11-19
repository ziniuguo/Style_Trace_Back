import 'dart:convert';

import 'package:http/http.dart';
import '../models/product_model.dart';

class ProductHttpService {
  final String productInfoURL = "";

  Future<List<Product>> getProduct() async {
    Response res = await get(Uri.parse(productInfoURL));

    if (res.statusCode == 200) {
      Iterable recordsList = jsonDecode(res.body);
      List<Product> allRecords =
          List<Product>.from(recordsList.map((item) => Product.fromJson(item)));
      return allRecords;
    } else {
      throw "Unable to retrieve data.";
    }
  }
}
