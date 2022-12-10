import 'package:flutter/material.dart';

import '../widgets/layer3/custom_buttons/custom_painter_handler.dart';

void main() {
  runApp(const PainterMainApp());
}

class PainterMainApp extends StatelessWidget {
  const PainterMainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Drawing Paths',
      home: Scaffold(
        body: Center(
          child: LeftCurveBtn(),
        ),
      ),
    );
  }
}