import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';

@Singleton(scope: authScope)
class KycRepository extends ChangeNotifier {
  KycRepository(this._storage);

  final SharedPreferences _storage;

  @PostConstruct()
  void init() {
    // here we should fetch validation status from backend for user
    // _hasValidatedEmail = _storage.getBool(_emailValidatedKey) ?? false;
    // _hasValidatedPhone = _storage.getBool(_phoneValidatedKey) ?? false;
    // _hasPassedKyc = _storage.getBool(_kycValidatedKey) ?? false;
  }

  bool _hasValidatedEmail = false;
  bool get hasValidatedEmail => _hasValidatedEmail;
  set hasValidatedEmail(bool value) {
    if (value == _hasValidatedEmail) return;
    _hasValidatedEmail = value;
    //_storage.setBool(_emailValidatedKey, value);
    notifyListeners();
  }

  bool _hasValidatedPhone = false;
  bool get hasValidatedPhone => _hasValidatedPhone;
  set hasValidatedPhone(bool value) {
    if (value == _hasValidatedPhone) return;
    _hasValidatedPhone = value;
    //_storage.setBool(_phoneValidatedKey, value);
    notifyListeners();
  }

  bool _hasPassedKyc = false;
  bool get hasPassedKyc => _hasPassedKyc;
  set hasPassedKyc(bool value) {
    if (value == _hasPassedKyc) return;
    _hasPassedKyc = value;
    //_storage.setBool(_kycValidatedKey, value);
    notifyListeners();
  }
}

// const _emailValidatedKey = 'emailValidated';
// const _phoneValidatedKey = 'phoneValidated';
// const _kycValidatedKey = 'kycValidated';
