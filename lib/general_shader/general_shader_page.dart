import 'dart:async';
import 'dart:ui';

import 'package:basic_shaders/general_shader/general_painter.dart';
import 'package:flutter/material.dart';

class GeneralShaderPage extends StatefulWidget {
  const GeneralShaderPage({super.key, required this.shaderPath});

  final String shaderPath;

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
      return CustomPaint(painter: GeneralPainter(shader!, delta));
    }
  }

  void _loadShader() async {
    var program = await FragmentProgram.fromAsset(widget.shaderPath);
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
