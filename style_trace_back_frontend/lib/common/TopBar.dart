import "package:flutter/material.dart";
import 'package:style_trace_back_frontend/common/AppColor.dart';
import 'AppTextStyle.dart';

AppBar topBar({String? pageName, Icon? leadingIcon, Icon? actionIcon}) {
  return AppBar(
    backgroundColor: AppColor.primaryGreen,
    actionsIconTheme: IconThemeData(size: 35.0),
    title: Text(pageName ?? "", style: AppTextStyle.pageHeader),
    leading: leadingIcon,
    actions: <Widget>[
      Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(child: actionIcon))
    ],
  );
}
