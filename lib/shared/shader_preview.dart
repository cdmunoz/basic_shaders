import 'dart:ui' as ui;

import 'package:basic_shaders/image_shader/image_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShaderPreview extends StatefulWidget {
  const ShaderPreview({
    super.key,
    required this.shaderPath,
    this.imagePath,
  });

  final String shaderPath;
  final String? imagePath;

  @override
  State<ShaderPreview> createState() => _ShaderPreviewState();
}

class _ShaderPreviewState extends State<ShaderPreview> {
  ui.FragmentShader? shader;
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final newShader = await _loadShader();
    final newImage = await _loadImage();

    if (mounted) {
      setState(() {
        shader = newShader;
        image = newImage;
      });
    }
  }

  Future<ui.FragmentShader> _loadShader() async {
    final program = await ui.FragmentProgram.fromAsset(widget.shaderPath);
    return program.fragmentShader();
  }

  Future<ui.Image?> _loadImage() async {
    if (widget.imagePath == null) {
      return null;
    }
    final imageData = await rootBundle.load(widget.imagePath!);
    return decodeImageFromList(imageData.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return CustomPaint(
      painter: ImagePainter(
        shader!,
        [0.0], // Static time for preview
        image != null ? [image] : [], // Pass image if it exists, otherwise empty list
      ),
    );
  }
}
