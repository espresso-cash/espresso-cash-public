import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';

@Singleton(scope: authScope)
class ProfileRepository extends ChangeNotifier {
  ProfileRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  bool get hasAllRequiredFields => country != null;

  String get name => _sharedPreferences.getString(nameKey) ?? '';

  set name(String value) {
    _sharedPreferences.setString(nameKey, value);
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

  @override
  @disposeMethod
  void dispose() {
    _sharedPreferences
      ..remove(nameKey)
      ..remove(countryKey);
    super.dispose();
  }
}

const nameKey = 'name';
const countryKey = 'country';
