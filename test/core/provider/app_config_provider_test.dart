import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:valu_task/core/constants/constants.dart';
import 'package:valu_task/core/provider/app_config_provider.dart';

import 'app_config_provider_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late AppConfigProvider appConfigProvider;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    appConfigProvider = AppConfigProvider(mockFlutterSecureStorage);
  });

  group("App Config Provider Testing", () {
    test('initial locale should be English', () {
      expect(appConfigProvider.locale, Constants.enLocaleKey);
    });

    test(
      'setLocale should update locale, save to storage, and notify listeners',
      () async {
        const newLocale = Constants.enLocaleKey;

        await appConfigProvider.setLocale(newLocale);

        expect(appConfigProvider.locale, newLocale);
      },
    );
  });
}
