import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authenticated/auth_scope.dart';
import '../models/profile.dart';

@Singleton(scope: authScope)
class ProfileRepository implements Disposable {
  ProfileRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  late final BehaviorSubject<Profile> _subject = BehaviorSubject.seeded(
    Profile(
      firstName: _sharedPreferences.getString(nameKey) ?? '',
      photoPath: _sharedPreferences.getString(photoKey),
      country: _sharedPreferences.getString(countryKey),
    ),
  );

  ValueStream<Profile> get profileStream => _subject.stream;

  Profile get profile => _subject.value;

  set profile(Profile value) {
    _sharedPreferences.setString(nameKey, value.firstName);
    final photoPath = value.photoPath;
    if (photoPath == null) {
      _sharedPreferences.remove(photoKey);
    } else {
      _sharedPreferences.setString(photoKey, photoPath);
    }
    final country = value.country;
    if (country == null) {
      _sharedPreferences.remove(countryKey);
    } else {
      _sharedPreferences.setString(countryKey, country);
    }
    _subject.add(value);
  }

  @override
  FutureOr<void> onDispose() {
    _sharedPreferences
      ..remove(nameKey)
      ..remove(photoKey)
      ..remove(countryKey);
    _subject.add(const Profile(firstName: ''));
  }
}

const nameKey = 'name';
const photoKey = 'photo';
const countryKey = 'country';
