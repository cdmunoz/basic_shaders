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
        child: SingleChildScrollView(
          child: Row(children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ImageShaderPage(
                            shaderPath: Assets.imageBlur,
                            imagePath: Assets.forest,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('Image Drop Blur'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const GeneralShaderPage(
                            shaderPath: Assets.artFractal,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('Art Fractal'),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
