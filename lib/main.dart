import 'package:basic_shaders/config/assets.dart';
import 'package:basic_shaders/config/shader_config.dart';
import 'package:basic_shaders/dynamic_shader/dynamic_shader_page.dart';
import 'package:basic_shaders/general_shader/general_shader_page.dart';
import 'package:basic_shaders/image_shader/image_shader_page.dart';
import 'package:basic_shaders/shared/shader_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shader Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Some Shaders'),
        backgroundColor: Colors.purple.shade50,
      ),
      backgroundColor: Colors.purple.shade50,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1,
            padding: const EdgeInsets.all(12),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: const [
              ShaderPage(shaderPath: Assets.artFractal),
              ShaderPage(
                shaderPath: Assets.imageBlur,
                imagePath: Assets.forest,
              ),
              ShaderPage(shaderPath: Assets.lsdEffect),
              ShaderPage(shaderPath: Assets.mandelbrotDistance),
              ShaderPage(shaderPath: Assets.theClouds),
              ShaderPage(shaderPath: Assets.scorpionTail),
              ShaderPage(shaderPath: Assets.waterRipple),
            ],
          ),
        ),
      ),
    );
  }
}

class ShaderPage extends StatelessWidget {
  const ShaderPage({
    required this.shaderPath,
    this.imagePath,
    super.key,
  });

  final String shaderPath;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    Widget page;
    if (shaderParameters.containsKey(shaderPath)) {
      page = DynamicShaderPage(
        shaderPath: shaderPath,
        parameters: shaderParameters[shaderPath]!,
      );
    } else if (imagePath == null) {
      page = GeneralShaderPage(shaderPath: shaderPath);
    } else {
      page = ImageShaderPage(shaderPath: shaderPath, imagePath: imagePath!);
    }

    void handleOnShaderTap() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    }

    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: handleOnShaderTap,
        child: ShaderPreview(shaderPath: shaderPath, imagePath: imagePath),
      ),
    );
  }
}
