import 'package:flutter/material.dart';

class AppTextStyle {
  static const TextStyle pageHeader = TextStyle(
    fontFamily: "Italiana",
    fontSize: 24.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    color: Color(0xFFFFFFFF),
  );

  static const TextStyle productBrandTextStyle = TextStyle(
      fontFamily: "Italiana",
      fontSize: 20.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: Color(0xFF1D1C28));

  static TextStyle productCategoryTextStyle = const TextStyle(
      fontFamily: "Italiana",
      fontSize: 20.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1D1C28));

  static TextStyle bodyTextStyle = const TextStyle(
      fontFamily: "Inter",
      fontSize: 12.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: Color(0xFF000000));

  static TextStyle priceTextStyle = const TextStyle(
      fontFamily: "Inter",
      fontSize: 13.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: Color(0xFF1D1C28));

  static TextStyle captionTextStyle = const TextStyle(
      fontFamily: "Inter",
      fontSize: 8.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300,
      color: Color(0xFF1D1C28));

  static TextStyle navBarLabelTextStyle = const TextStyle(
      fontFamily: "Inter",
      fontSize: 12.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFFFF));
}
