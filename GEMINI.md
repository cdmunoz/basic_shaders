# Project Overview

This is a Flutter project that demonstrates how to use custom shaders. The shaders are taken from the ShaderToy community and adapted for Flutter. The application displays a grid of shader examples, and tapping on each one opens a detailed view.

**Key Technologies:**

*   Flutter
*   GLSL (OpenGL Shading Language)

**Architecture:**

*   The main entry point is `lib/main.dart`, which sets up the application and the home page.
*   The home page (`HomePage`) displays a `GridView` of `ShaderPage` widgets.
*   Each `ShaderPage` can be a `GeneralShaderPage` or an `ImageShaderPage`, depending on whether it uses an image as a texture.
*   The shaders are located in the `shaders` directory and are defined in `.frag` files.
*   Assets, including images and shaders, are declared in `pubspec.yaml`.
*   The `lib/config/assets.dart` file contains a class with static constants for asset paths, which is a good practice for managing assets.

# Building and Running

To build and run this project, you need to have the Flutter SDK installed.

1.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
2.  **Run the app:**
    ```bash
    flutter run
    ```

**Testing:**

To run the tests, use the following command:

```bash
flutter test
```

# Development Conventions

*   **Asset Management:** Asset paths are managed in the `lib/config/assets.dart` file. When adding new assets, declare them in `pubspec.yaml` and then add a corresponding constant to the `Assets` class.
*   **Shaders:** Shaders are written in GLSL and have the `.frag` extension. They are located in the `shaders` directory. To add a new shader, you need to add it to the `shaders` directory and declare it in the `pubspec.yaml` file.
*   **Code Style:** The project follows the standard Dart and Flutter code style. The `analysis_options.yaml` file includes `flutter_lints` for enforcing good coding practices.
