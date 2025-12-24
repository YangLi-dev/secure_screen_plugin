import 'package:secure_screen_plugin_platform_interface/secure_screen_plugin_platform_interface.dart';

SecureScreenPluginPlatform get _platform => SecureScreenPluginPlatform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}

/// Enables the secure screen.
Future<void> enableSecureScreen() async {
  await _platform.enable();
}

/// Disables the secure screen.
Future<void> disableSecureScreen() async {
  await _platform.disable();
}

/// Listens to screenshot events.
///
/// Returns a stream that emits events when a screenshot is detected.
/// On iOS, this will emit "screenshot_detected" when a screenshot is taken.
///
/// Example:
/// ```dart
/// secure_screen_plugin.onScreenshot().listen((event) {
///   print('Screenshot detected: $event');
/// });
/// ```
Stream<String> onScreenshot() {
  return _platform.onScreenshot();
}
