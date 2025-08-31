# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Flutter application demonstrating custom fragment shaders adapted from ShaderToy community. The app showcases various visual effects including fractals, blur effects, and animated patterns.

## Architecture

### Shader System
- **General shaders**: Standalone visual effects using time-based animation
- **Image shaders**: Effects that process input images with custom filters
- Two main painter implementations:
  - `GeneralPainter` (lib/general_shader/general_painter.dart:5) - handles time-based shaders
  - `ImagePainter` (lib/image_shader/image_painter.dart:6) - handles image-processing shaders

### Project Structure
- `lib/main.dart` - Main app entry with shader selection grid
- `lib/config/assets.dart` - Asset path constants for shaders and images
- `lib/general_shader/` - Components for time-animated shaders
- `lib/image_shader/` - Components for image-processing shaders
- `shaders/` - Fragment shader files (.frag format)
- `assets/images/` - Image assets used by shaders

### Shader Integration
- Shaders declared in pubspec.yaml under `flutter.shaders`
- Loaded using `FragmentProgram.fromAsset()`
- Uniforms passed via `setFloat()` and `setImageSampler()`
- Standard uniform pattern: width, height, time, [additional params]

## Development Commands

```bash
# Clean and setup project
flutter clean && flutter pub get

# Run the application
flutter run

# Build for production
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web

# Run tests
flutter test

# Get dependencies
flutter pub get

# Analyze code
flutter analyze
```

## Android Configuration

This project has been updated for modern Android development:
- **AGP**: 8.1.0 (Android Gradle Plugin)
- **Gradle**: 8.0
- **Kotlin**: 1.9.10
- **CompileSdk**: 34
- **TargetSdk**: 34
- **MinSdk**: 21
- **Java**: Version 11
- **NDK**: 25.1.8937393

## Adding New Shaders

1. Place `.frag` file in `shaders/` directory
2. Add shader path to pubspec.yaml under `flutter.shaders`
3. Add asset constant to `lib/config/assets.dart`
4. Add button in `main.dart` grid with navigation logic
5. Use `GeneralShaderPage` for time-based effects or `ImageShaderPage` for image processing