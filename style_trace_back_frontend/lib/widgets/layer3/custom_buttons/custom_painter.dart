import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/common/AppColor.dart';

class LeftCurveBtnPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColor.secondaryYellowDark
      ..style = PaintingStyle.fill;
    double w = size.width;
    double h = size.height;

    var path = Path()
      ..moveTo(0, 0)
      ..cubicTo(w/5, 39*h/134, w, 34*h/134, w, h / 2)
      ..cubicTo(w, 100*h/134, w/5, 95*h/134, 0, h)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RightCurveBtnPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColor.secondaryYellowDark
      ..style = PaintingStyle.fill;
    double w = size.width;
    double h = size.height;

    var path = Path()
      ..moveTo(w, 0)
      ..cubicTo(4*w/5, 39*h/134, 0, 34*h/134, 0, h / 2)
      ..cubicTo(0, 100*h/134, 4*w/5, 95*h/134, w, h)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


void _debugL(Object o) {
  log("custom_painter.dart: - $o");
}
