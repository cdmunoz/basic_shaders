import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:basic_shaders/image_shader/image_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageShaderPage extends StatefulWidget {
  const ImageShaderPage({
    super.key,
    required this.shaderPath,
    required this.imagePath,
    // Optional parameters for shaders that have dynamic values.
    // Used for the preview of dynamic shaders.
    this.parameters,
  });

  final String shaderPath;
  final String imagePath;
  final List<double>? parameters;

  @override
  State<ImageShaderPage> createState() => _ImageShaderPageState();
}

class _ImageShaderPageState extends State<ImageShaderPage> {
  late Timer timer;
  double delta = 0;
  FragmentShader? shader;
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadShader();
    });
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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
      // Combine time (delta) and any other dynamic parameters into one list for the painter.
      final uniforms = [delta, ...?widget.parameters];
      return CustomPaint(painter: ImagePainter(shader!, uniforms, [image]));
    }
  }

  Future<void> _loadShader() async {
    final imageData = await rootBundle.load(widget.imagePath);
    image = await decodeImageFromList(imageData.buffer.asUint8List());

    final program = await FragmentProgram.fromAsset(widget.shaderPath);
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
