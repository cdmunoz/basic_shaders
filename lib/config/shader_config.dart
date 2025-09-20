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
};
