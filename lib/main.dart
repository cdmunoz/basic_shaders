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
    final textTheme = Theme.of(context).textTheme;
    final style = textTheme.headlineSmall?.copyWith(color: Colors.deepPurple);

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
            children: [
              ElevatedButton(
                onPressed: () {
                  _navigateToGeneral(context, Assets.artFractal);
                },
                child: Text(
                  'Art Fractal',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _navigateToImage(
                    context,
                    Assets.imageBlur,
                    Assets.forest,
                  );
                },
                child: Text(
                  'Image Drop Blur',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _navigateToGeneral(context, Assets.lsdEffect);
                },
                child: Text(
                  'LSD Effect',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _navigateToGeneral(context, Assets.mandelbrotDistance);
                },
                child: Text(
                  'Mandelbrot Distance',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _navigateToGeneral(context, Assets.theClouds);
                },
                child: Text(
                  'The Clouds',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _navigateToGeneral(context, Assets.scorpionTail);
                },
                child: Text(
                  'Scorpion Tail',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _navigateToGeneral(context, Assets.waterRipple);
                },
                child: Text(
                  'Water Ripple',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
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
