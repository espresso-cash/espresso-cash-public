import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_auth_preference.dart';

@injectable
class LocalAuthRepository extends ChangeNotifier {
  LocalAuthRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  LocalAuthPreference get askForBiometrics {
    final value = _sharedPreferences.getString(_localAuthKey);
    switch (value) {
      case 'enabled':
        return const LocalAuthPreference.enabled();
      case 'disabled':
        return const LocalAuthPreference.disabled();
      default:
        return const LocalAuthPreference.neverAsked();
    }
  }

  Future<void> toggleAskForBiometrics(LocalAuthPreference preference) async {
    await _sharedPreferences.setString(
      _localAuthKey,
      preference.map(
        disabled: always('disabled'),
        enabled: always('enabled'),
        neverAsked: always('neverAsked'),
      ),
    );
    notifyListeners();
  }

  Future<void> clear() => _sharedPreferences.remove(_localAuthKey);
}

const _localAuthKey = 'localAuthKey';
