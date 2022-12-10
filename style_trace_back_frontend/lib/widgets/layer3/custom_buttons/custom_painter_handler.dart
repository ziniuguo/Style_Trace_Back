import 'dart:developer';

import 'package:flutter/material.dart';

import 'custom_painter.dart';

class LeftCurveBtn extends StatelessWidget {
  const LeftCurveBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _debugL('LeftCurveBtnPressed'),
      child: CustomPaint(
        size: const Size(50, 134),
        painter: LeftCurveBtnPainter(),
      ),
    );
  }
}

class RightCurveBtn extends StatelessWidget {
  const RightCurveBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _debugL('RightCurveBtnPressed'),
      child: CustomPaint(
        size: const Size(50, 134),
        painter: RightCurveBtnPainter(),
      ),
    );
  }
}

void _debugL(Object o) {
  log("custom_painter_handler.dart: - $o");
}
