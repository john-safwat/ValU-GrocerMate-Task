import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:valu_task/core/constants/constants.dart';
import 'package:valu_task/core/l10n/translation/app_localizations.dart';

@singleton
class AppConfigProvider extends ChangeNotifier {
  String _locale = Constants.enLocaleKey;

  late AppLocalizations localizations;

  final FlutterSecureStorage _flutterSecureStorage;

  AppConfigProvider(this._flutterSecureStorage);

  String get locale => _locale;

  Future<void> setLocale(String locale) async {
    if (locale == _locale) return;
    _locale = locale;
    await _flutterSecureStorage.write(key: Constants.localeKey, value: _locale);
    notifyListeners();
  }
}
