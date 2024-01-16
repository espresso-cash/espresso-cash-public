import 'dart:async';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/listenable_ext.dart';
import '../../authenticated/auth_scope.dart';
import '../data/profile_repository.dart';

@Singleton(scope: authScope)
class WalletService implements Disposable {
  WalletService(
    this._sharedPreferences,
    this._profileRepository,
    this._cryptopleaseClient,
  );

  final CryptopleaseClient _cryptopleaseClient;
  final SharedPreferences _sharedPreferences;
  final ProfileRepository _profileRepository;

  StreamSubscription<void>? _subscription;

  @PostConstruct(preResolve: true)
  void init() {
    final shouldDoInitialSync =
        !(_sharedPreferences.getBool(_countrySyncedKey) ?? false);

    if (shouldDoInitialSync) {
      _sharedPreferences.setBool(_countrySyncedKey, true);
    }

    _subscription = _profileRepository
        .toStream()
        .map((event) => event.country)
        .startWith(shouldDoInitialSync ? _profileRepository.country : null)
        .whereNotNull()
        .distinct()
        .map((country) => WalletCountryRequestDto(countryCode: country))
        .switchMap((request) async* {
      await _cryptopleaseClient.updateUserWalletCountry(request);
    }).listen(null);
  }

  @override
  void onDispose() {
    _subscription?.cancel();
  }
}

const _countrySyncedKey = 'walletCountrySynced';
