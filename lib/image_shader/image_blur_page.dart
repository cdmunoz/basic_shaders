import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:basic_shaders/config/assets.dart';
import 'package:basic_shaders/image_shader/image_painter.dart';
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
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: _body(),
      ),
    );
  }

  Widget _body() {
    if (shader == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return CustomPaint(painter: ImagePainter(shader!, [delta], [image]));
    }
  }

  Future<void> _loadShader() async {
    final imageData = await rootBundle.load(Assets.forest);
    image = await decodeImageFromList(imageData.buffer.asUint8List());

    final program = await FragmentProgram.fromAsset(Assets.imageBlur);
    shader = program.fragmentShader();
    setState(() {
      //trigger a repaint
    });

    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!mounted) return;
      setState(() {
        delta += 1 / 60;
      });
    });
  }
}
