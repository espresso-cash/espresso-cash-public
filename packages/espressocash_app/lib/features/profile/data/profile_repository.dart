import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';

@Singleton(scope: authScope)
class ProfileRepository extends ChangeNotifier {
  ProfileRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  bool get hasAllRequiredFields =>
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      email.isNotEmpty &&
      country != null;

  String get fullName =>
      [firstName, lastName].where((it) => it.isNotEmpty).join(' ');

  String get initials =>
      (substring(firstName, 0, 1) + substring(lastName, 0, 1)).toUpperCase();

  String get firstName => _sharedPreferences.getString(firstNameKey) ?? '';

  set firstName(String value) {
    _sharedPreferences.setString(firstNameKey, value);
    notifyListeners();
  }

  String get lastName => _sharedPreferences.getString(lastNameKey) ?? '';

  set lastName(String value) {
    _sharedPreferences.setString(lastNameKey, value);
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
      ..remove(firstNameKey)
      ..remove(lastNameKey)
      ..remove(photoKey)
      ..remove(countryKey)
      ..remove(emailKey);
    super.dispose();
  }
}

const firstNameKey = 'name';
const lastNameKey = 'lastName';
const photoKey = 'photo';
const countryKey = 'country';
const emailKey = 'email';
