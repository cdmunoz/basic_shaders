import 'package:basic_shaders/config/assets.dart';
import 'package:basic_shaders/config/shader_config.dart';
import 'package:basic_shaders/dynamic_shader/dynamic_image_shader_page.dart';
import 'package:basic_shaders/dynamic_shader/dynamic_shader_page.dart';
import 'package:basic_shaders/general_shader/general_shader_page.dart';
import 'package:basic_shaders/image_shader/image_shader_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              ShaderPage(shaderPath: Assets.dwarfStar),
              ShaderPage(
                shaderPath: Assets.imageBlur,
                imagePath: Assets.forest,
              ),
              ShaderPage(shaderPath: Assets.lsdEffect),
              ShaderPage(shaderPath: Assets.mandelbrotDistance),
              ShaderPage(shaderPath: Assets.scorpionTail),
              ShaderPage(shaderPath: Assets.theClouds),
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
    Widget previewWidget;
    Widget detailPage;

    final dynamicParams = shaderParameters[shaderPath];

    if (dynamicParams != null) {
      // This is a dynamic shader
      if (imagePath != null) {
        // Dynamic image shader
        detailPage = DynamicImageShaderPage(
          shaderPath: shaderPath,
          parameters: dynamicParams,
          imagePath: imagePath!,
        );
        previewWidget = ImageShaderPage(
          shaderPath: shaderPath,
          imagePath: imagePath!,
          parameters: dynamicParams.map((p) => p.initialValue).toList(),
        );
      } else {
        // Dynamic general shader
        detailPage = DynamicShaderPage(
          shaderPath: shaderPath,
          parameters: dynamicParams,
        );
        previewWidget = GeneralShaderPage(
          shaderPath: shaderPath,
          parameters: dynamicParams.map((p) => p.initialValue).toList(),
        );
      }
    } else if (imagePath == null) {
      // This is a standard general shader
      detailPage = GeneralShaderPage(shaderPath: shaderPath);
      previewWidget = detailPage;
    } else {
      // This is a standard image shader
      detailPage =
          ImageShaderPage(shaderPath: shaderPath, imagePath: imagePath!);
      previewWidget = detailPage;
    }

    void handleOnShaderTap() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => detailPage,
        ),
      );
    }

    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: handleOnShaderTap,
        child: previewWidget,
      ),
    );
  }
}
