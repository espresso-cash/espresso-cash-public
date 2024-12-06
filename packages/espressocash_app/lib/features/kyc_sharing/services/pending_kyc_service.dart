import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';

@Singleton(scope: authScope)
class PendingKycService {
  PendingKycService(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;
  final _controller = BehaviorSubject<DateTime?>();

  Stream<DateTime?> get pendingKycStream => _controller.stream;

  bool get hasPendingKyc =>
      _sharedPreferences.getString(_kycStartedKey) != null;

  @PostConstruct()
  void init() {
    final currentDate = _getCurrentKycDate();
    _controller.add(currentDate);
  }

  void create() {
    if (hasPendingKyc) return;

    final now = DateTime.now().toIso8601String();
    _sharedPreferences.setString(_kycStartedKey, now);
    _controller.add(_getCurrentKycDate());
  }

  void remove() {
    _sharedPreferences.remove(_kycStartedKey);
    _controller.add(null);
  }

  DateTime? _getCurrentKycDate() {
    final dateString = _sharedPreferences.getString(_kycStartedKey);

    return dateString != null ? DateTime.parse(dateString) : null;
  }

  @disposeMethod
  void dispose() {
    _controller.close();
    _sharedPreferences.remove(_kycStartedKey);
  }
}

const _kycStartedKey = 'kycStartedKey';
