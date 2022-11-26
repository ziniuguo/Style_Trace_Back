import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:style_trace_back_frontend/models/product_model.dart';

import '../common/Config.dart';

Future<List<Product>> uploadScanningImage(String userId, File file) async {
  final Dio dio = Dio();
  String fileName = file.path.split('/').last;
  const String baseUrl = Config.baseUrl;
  const String postUrl = "$baseUrl/postImg";

  FormData formData = FormData.fromMap({
    "userId": userId,
    "myFile": await MultipartFile.fromFile(
      file.path,
      filename: fileName,
    ),
  });

  Response res = await dio.post(postUrl, data: formData);
  Iterable recordsList = jsonDecode(res.data);
  List<Product> allRecords =
      List<Product>.from(recordsList.map((item) => Product.fromJson(item)));
  return allRecords;
}
