import 'dart:async';
import 'dart:ui';

import 'package:basic_shaders/dynamic_shader/dynamic_painter.dart';
import 'package:basic_shaders/models/shader_parameter.dart';
import 'package:flutter/material.dart';

class DynamicShaderPage extends StatefulWidget {
  const DynamicShaderPage({
    super.key,
    required this.shaderPath,
    required this.parameters,
  });

  final String shaderPath;
  final List<ShaderParameter> parameters;

  @override
  State<DynamicShaderPage> createState() => _DynamicShaderPageState();
}

class _DynamicShaderPageState extends State<DynamicShaderPage> {
  late Timer timer;
  double delta = 0;
  FragmentShader? shader;
  late List<double> parameterValues;

  @override
  void initState() {
    super.initState();
    parameterValues = widget.parameters.map((p) => p.initialValue).toList();
    _loadShader();
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
      return Column(
        children: [
          Expanded(
            child: CustomPaint(
              painter: DynamicPainter(shader!, delta, parameterValues),
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
  }

  List<Widget> _buildSliders() {
    return widget.parameters.asMap().entries.map((entry) {
      int index = entry.key;
      ShaderParameter param = entry.value;
      final value = parameterValues[index];

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${param.name}: ${value.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
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
