import 'dart:ui';

import 'package:flutter/material.dart';

class GeneralPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;
  final List<double>? parameters;

  GeneralPainter(this.shader, this.time, {this.parameters});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);

    if (parameters != null) {
      for (var i = 0; i < parameters!.length; i++) {
        shader.setFloat(i + 3, parameters![i]);
      }
    }

    paint.shader = shader;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
