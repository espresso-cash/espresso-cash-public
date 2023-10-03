import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authenticated/auth_scope.dart';

@Singleton(scope: authScope)
class ProfileRepository extends ChangeNotifier {
  ProfileRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  bool get hasAllRequiredFields =>
      firstName.isNotEmpty && email.isNotEmpty && country != null;

  String get firstName => _sharedPreferences.getString(nameKey) ?? '';

  set firstName(String value) {
    _sharedPreferences.setString(nameKey, value);
    notifyListeners();
  }

  String? get photoPath => _sharedPreferences.getString(photoKey);

  set photoPath(String? value) {
    if (value == null) {
      _sharedPreferences.remove(photoKey);
    } else {
      _sharedPreferences.setString(photoKey, value);
    }
    notifyListeners();
  }

  String? get country => _sharedPreferences.getString(countryKey);

  set country(String? value) {
    if (value == null) {
      _sharedPreferences.remove(countryKey);
    } else {
      _sharedPreferences.setString(countryKey, value);
    }
    notifyListeners();
  }

  String get email => _sharedPreferences.getString(emailKey) ?? '';

  set email(String value) {
    _sharedPreferences.setString(emailKey, value);
    notifyListeners();
  }

  @override
  @disposeMethod
  void dispose() {
    _sharedPreferences
      ..remove(nameKey)
      ..remove(photoKey)
      ..remove(countryKey)
      ..remove(emailKey);
    super.dispose();
  }
}

const nameKey = 'name';
const photoKey = 'photo';
const countryKey = 'country';
const emailKey = 'email';
