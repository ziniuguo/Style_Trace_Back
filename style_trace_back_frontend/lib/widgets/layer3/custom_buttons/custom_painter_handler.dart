import 'dart:developer';

import 'package:flutter/material.dart';

import 'custom_painter.dart';

class LeftCurveBtn extends StatelessWidget {
  const LeftCurveBtn({
    super.key,
    required this.toDo,
    required this.size,
  });

  final void Function() toDo;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toDo,
      child: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height / 8,
            left: 0,
            child: CustomPaint(
              size: size,
              painter: LeftCurveBtnPainter(),
            ),
          ),
          Positioned(
            left: 6,
            bottom: MediaQuery.of(context).size.height / 8 + 50,
            child: Image.asset(
              'assets/images/pick_img_btn.png',
              scale: 0.9,
            ),
          )
        ],
      ),
    );
  }
}

class RightCurveBtn extends StatelessWidget {
  const RightCurveBtn({
    super.key,
    required this.toDo,
    required this.size,
  });

  final void Function() toDo;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toDo,
      child: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height / 8,
            right: 0,
            child: CustomPaint(
              size: size,
              painter: RightCurveBtnPainter(),
            ),
          ),
          Positioned(
            right: 6,
            bottom: MediaQuery.of(context).size.height / 8 + 50,
            child: Image.asset(
              'assets/images/take_photo_btn.png',
              scale: 0.9,
            ),
          )
        ],
      ),
    );
  }
}

void _debugL(Object o) {
  log("custom_painter_handler.dart: - $o");
}
