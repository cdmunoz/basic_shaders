import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:basic_shaders/image_shader/image_painter.dart';
import 'package:basic_shaders/models/shader_parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DynamicImageShaderPage extends StatefulWidget {
  const DynamicImageShaderPage({
    super.key,
    required this.shaderPath,
    required this.parameters,
    required this.imagePath,
  });

  final String shaderPath;
  final List<ShaderParameter> parameters;
  final String imagePath;

  @override
  State<DynamicImageShaderPage> createState() => _DynamicImageShaderPageState();
}

class _DynamicImageShaderPageState extends State<DynamicImageShaderPage> {
  late Timer timer;
  double delta = 0;
  ui.FragmentShader? shader;
  ui.Image? image;
  late List<double> parameterValues;

  @override
  void initState() {
    super.initState();
    parameterValues = widget.parameters.map((p) => p.initialValue).toList();
    _load();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    final newShader = await FragmentProgram.fromAsset(widget.shaderPath);
    final imageData = await rootBundle.load(widget.imagePath);
    final newImage = await decodeImageFromList(imageData.buffer.asUint8List());

    if (mounted) {
      setState(() {
        shader = newShader.fragmentShader();
        image = newImage;
      });

      timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
        if (!mounted) return;
        setState(() {
          delta += 1 / 60;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: _body(),
    );
  }

  Widget _body() {
    if (shader == null || image == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final uniforms = [delta, ...parameterValues];

    return Column(
      children: [
        Expanded(
          child: CustomPaint(
            painter: ImagePainter(shader!, uniforms, [image]),
            child: Container(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.black.withOpacity(0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildSliders(),
          ),
        )
      ],
    );
  }

  List<Widget> _buildSliders() {
    return widget.parameters.asMap().entries.map((entry) {
      int index = entry.key;
      ShaderParameter param = entry.value;
      final value = parameterValues[index];

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${param.name}: ${value.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white)),
          Slider(
            value: value,
            min: param.minValue,
            max: param.maxValue,
            divisions: 100,
            label: value.toStringAsFixed(2),
            onChanged: (newValue) {
              setState(() {
                parameterValues[index] = newValue;
              });
            },
          ),
        ],
      );
    }).toList();
  }
}
