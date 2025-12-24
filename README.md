# secure_screen_plugin

[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]
[![Very Good Ventures][logo_black]][very_good_ventures_link_light]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A Flutter plugin that provides secure screen functionality to prevent screenshots and screen recording on Android and iOS platforms.

## Features

- 🔒 Enable/disable secure screen on Android and iOS
- 📱 Prevents screenshots and screen recording
- 🎯 Simple and easy-to-use API
- 🏗️ Built with federated plugin architecture

## Installation

Add `secure_screen_plugin` to your `pubspec.yaml`:

```yaml
dependencies:
  secure_screen_plugin: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Import the package

```dart
import 'package:secure_screen_plugin/secure_screen_plugin.dart';
```

### Enable secure screen

To prevent screenshots and screen recording:

```dart
await enableSecureScreen();
```

### Disable secure screen

To allow screenshots and screen recording again:

```dart
await disableSecureScreen();
```

### Listen to screenshot events (iOS only)

To detect when a screenshot is taken on iOS:

```dart
import 'dart:async';
import 'package:secure_screen_plugin/secure_screen_plugin.dart';

// Listen to screenshot events
StreamSubscription<String>? _screenshotSubscription;

void startListening() {
  _screenshotSubscription = onScreenshot().listen((event) {
    print('Screenshot detected: $event');
    // Handle screenshot event
  });
}

void stopListening() {
  _screenshotSubscription?.cancel();
  _screenshotSubscription = null;
}
```

### Complete Example

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:secure_screen_plugin/secure_screen_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSecure = false;
  StreamSubscription<String>? _screenshotSubscription;

  @override
  void initState() {
    super.initState();
    // Start listening to screenshot events (iOS only)
    _screenshotSubscription = onScreenshot().listen((event) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Screenshot detected!')),
      );
    });
  }

  @override
  void dispose() {
    _screenshotSubscription?.cancel();
    super.dispose();
  }

  Future<void> _toggleSecureScreen() async {
    if (_isSecure) {
      await disableSecureScreen();
    } else {
      await enableSecureScreen();
    }
    setState(() {
      _isSecure = !_isSecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Secure Screen Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _toggleSecureScreen,
            child: Text(_isSecure ? 'Disable Secure Screen' : 'Enable Secure Screen'),
          ),
        ),
      ),
    );
  }
}
```

## Platform Support

- ✅ Android
- ✅ iOS
- ❌ Web (not supported)
- ❌ macOS (not supported)
- ❌ Windows (not supported)
- ❌ Linux (not supported)

## Notes

- On Android, this plugin uses `FLAG_SECURE` to prevent screenshots and screen recording.
- On iOS, this plugin uses `UIScreen.capturedDidChangeNotification` to detect screen recording attempts.
- The secure screen feature is automatically disabled when the app goes to the background.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
[very_good_ventures_link]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=core
[very_good_ventures_link_dark]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=core#gh-dark-mode-only
[very_good_ventures_link_light]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=core#gh-light-mode-only
