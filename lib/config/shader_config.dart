import 'package:basic_shaders/config/assets.dart';
import 'package:basic_shaders/models/shader_parameter.dart';

final shaderParameters = {
  Assets.artFractal: [
    ShaderParameter(
      name: 'Zoom',
      initialValue: 1.5,
      minValue: 0.5,
      maxValue: 5.0,
    ),
    ShaderParameter(
      name: 'Wave Frequency',
      initialValue: 8.0,
      minValue: 1.0,
      maxValue: 20.0,
    ),
  ],
  Assets.imageBlur: [
    ShaderParameter(
      name: 'Pixelation',
      initialValue: 32.0,
      minValue: 4.0,
      maxValue: 128.0,
    ),
    ShaderParameter(
      name: 'Wave Frequency',
      initialValue: 50.0,
      minValue: 5.0,
      maxValue: 150.0,
    ),
    ShaderParameter(
      name: 'Wave Amplitude',
      initialValue: 0.06,
      minValue: 0.0,
      maxValue: 0.3,
    ),
  ],
  Assets.lsdEffect: [
    ShaderParameter(
      name: 'Stripes',
      initialValue: 18,
      minValue: 2,
      maxValue: 50,
    ),
    ShaderParameter(
      name: 'Distortion',
      initialValue: 10,
      minValue: 1,
      maxValue: 30,
    ),
  ],
  Assets.mandelbrotDistance: [
    ShaderParameter(
      name: 'Color Factor',
      initialValue: 4.0,
      minValue: 0.0,
      maxValue: 20.0,
    ),
    ShaderParameter(
      name: 'Color Exponent',
      initialValue: 0.2,
      minValue: 0.1,
      maxValue: 1.0,
    ),
  ],
  Assets.theClouds: [
    ShaderParameter(
      name: 'Cloud Scale',
      initialValue: 1.1,
      minValue: 0.5,
      maxValue: 5.0,
    ),
    ShaderParameter(
      name: 'Cloud Cover',
      initialValue: 0.2,
      minValue: -1.0,
      maxValue: 1.0,
    ),
    ShaderParameter(
      name: 'Cloud Dark',
      initialValue: 0.5,
      minValue: 0.0,
      maxValue: 1.0,
    ),
    ShaderParameter(
      name: 'Cloud Light',
      initialValue: 0.3,
      minValue: 0.0,
      maxValue: 1.0,
    ),
  ],
  Assets.scorpionTail: [
    ShaderParameter(
      name: 'Box Size',
      initialValue: 1.0,
      minValue: 0.5,
      maxValue: 2.0,
    ),
    ShaderParameter(
      name: 'Quality (Iterations)',
      initialValue: 150,
      minValue: 50,
      maxValue: 300,
    ),
    ShaderParameter(
      name: 'Shape Param',
      initialValue: 1.95,
      minValue: 1.85,
      maxValue: 2.05,
    ),
  ],
  Assets.dwarfStar: [
    ShaderParameter(
      name: 'Frequency',
      initialValue: 10.0,
      minValue: 5.0,
      maxValue: 50.0,
    ),
    ShaderParameter(
      name: 'Speed',
      initialValue: 1.0,
      minValue: 0.1,
      maxValue: 5.0,
    ),
    ShaderParameter(
      name: 'Amplitude',
      initialValue: 0.03,
      minValue: 0.0,
      maxValue: 0.1,
    ),
  ],
  Assets.waterRipple: [
    ShaderParameter(
      name: 'Frequency',
      initialValue: 10.0,
      minValue: 5.0,
      maxValue: 50.0,
    ),
    ShaderParameter(
      name: 'Speed',
      initialValue: 1.0,
      minValue: 0.1,
      maxValue: 5.0,
    ),
    ShaderParameter(
      name: 'Point Size',
      initialValue: 0.01,
      minValue: 0.001,
      maxValue: 0.05,
    ),
  ],
};
