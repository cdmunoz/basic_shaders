import 'package:basic_shaders/config/assets.dart';
import 'package:basic_shaders/general_shader/general_shader_page.dart';
import 'package:basic_shaders/image_shader/image_shader_page.dart';
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: SingleChildScrollView(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _navigateToGeneral(context, Assets.artFractal);
                    },
                    child: const Text('Art Fractal'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _navigateToImage(
                        context,
                        Assets.imageBlur,
                        Assets.forest,
                      );
                    },
                    child: const Text('Image Drop Blur'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _navigateToGeneral(context, Assets.lsdEffect);
                    },
                    child: const Text('LSD Effect'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _navigateToGeneral(context, Assets.theClouds);
                    },
                    child: const Text('The Clouds'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _navigateToGeneral(context, Assets.waterRipple);
                    },
                    child: const Text('Water Ripple'),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  void _navigateToGeneral(BuildContext context, String shaderPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GeneralShaderPage(shaderPath: shaderPath);
        },
      ),
    );
  }

  void _navigateToImage(
    BuildContext context,
    String shaderPath,
    String imagePath,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ImageShaderPage(
            shaderPath: shaderPath,
            imagePath: imagePath,
          );
        },
      ),
    );
  }
}
