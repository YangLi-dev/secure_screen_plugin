import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:secure_screen_plugin/secure_screen_plugin.dart';
import 'package:secure_screen_plugin_platform_interface/secure_screen_plugin_platform_interface.dart';

class MockSecureScreenPluginPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements SecureScreenPluginPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(SecureScreenPluginPlatform, () {
    late SecureScreenPluginPlatform secureScreenPluginPlatform;

    setUp(() {
      secureScreenPluginPlatform = MockSecureScreenPluginPlatform();
      SecureScreenPluginPlatform.instance = secureScreenPluginPlatform;
    });

    group('getPlatformName', () {
      test(
        'returns correct name when platform implementation exists',
        () async {
          const platformName = '__test_platform__';
          when(
            () => secureScreenPluginPlatform.getPlatformName(),
          ).thenAnswer((_) async => platformName);

          final actualPlatformName = await getPlatformName();
          expect(actualPlatformName, equals(platformName));
        },
      );

      test(
        'throws exception when platform implementation is missing',
        () async {
          when(
            () => secureScreenPluginPlatform.getPlatformName(),
          ).thenAnswer((_) async => null);

          expect(getPlatformName, throwsException);
        },
      );
    });
  });
}
