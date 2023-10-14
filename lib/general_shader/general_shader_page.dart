import 'dart:async';
import 'dart:ui';

import 'package:basic_shaders/config/assets.dart';
import 'package:basic_shaders/general_shader/general_painter.dart';
import 'package:flutter/material.dart';

class GeneralShaderPage extends StatefulWidget {
  const GeneralShaderPage({super.key});

  @override
  State<GeneralShaderPage> createState() => _GeneralShaderPageState();
}

class _GeneralShaderPageState extends State<GeneralShaderPage> {
  late Timer timer;
  double delta = 0;
  FragmentShader? shader;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadShader();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return CustomPaint(painter: GeneralPainter(shader!, delta));
    }
  }

  void _loadShader() async {
    var program = await FragmentProgram.fromAsset(Assets.artFractal);
    shader = program.fragmentShader();
    setState(() {
      // trigger a repaint
    });

    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        delta += 1 / 60;
      });
    });
  }
}