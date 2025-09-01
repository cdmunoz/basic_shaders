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
      initialValue: 10.0,
      minValue: 1.0,
      maxValue: 50.0,
    ),
    ShaderParameter(
      name: 'Wave Frequency',
      initialValue: 50.0,
      minValue: 5.0,
      maxValue: 100.0,
    ),
    ShaderParameter(
      name: 'Wave Amplitude',
      initialValue: 0.06,
      minValue: 0.0,
      maxValue: 0.2,
    ),
  ],
};
