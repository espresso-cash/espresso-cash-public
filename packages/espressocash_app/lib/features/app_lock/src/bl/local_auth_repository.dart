import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_auth_preference.dart';

@injectable
class LocalAuthRepository extends ChangeNotifier {
  LocalAuthRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  LocalAuthPreference get localAuthPreference {
    final value = _sharedPreferences.getBool(_localAuthKey);
    if (value == null) return const LocalAuthPreference.neverAsked();

    return value
        ? const LocalAuthPreference.enabled()
        : const LocalAuthPreference.disabled();
  }

  Future<void> savePreference(bool useBiometrics) async {
    await _sharedPreferences.setBool(_localAuthKey, useBiometrics);
    notifyListeners();
  }

  Future<void> clear() => _sharedPreferences.remove(_localAuthKey);
}

const _localAuthKey = 'localAuthKey';
