import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:basic_shaders/image_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageBlurPage extends StatefulWidget {
  const ImageBlurPage({super.key});

  @override
  State<ImageBlurPage> createState() => _ImageBlurPageState();
}

class _ImageBlurPageState extends State<ImageBlurPage> {
  late Timer timer;
  double delta = 0;
  FragmentShader? shader;
  ui.Image? image;

  void loadMyShader() async {
    final imageData = await rootBundle.load('assets/forest_shader.png');
    image = await decodeImageFromList(imageData.buffer.asUint8List());

    var program = await FragmentProgram.fromAsset('shaders/image_blur.frag');
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

  @override
  void initState() {
    super.initState();
    loadMyShader();
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
      return CustomPaint(painter: ImagePainter(shader!, [delta], [image]));
    }
  }
}
