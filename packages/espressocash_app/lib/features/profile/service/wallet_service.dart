import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';
import '../../analytics/analytics_manager.dart';
import '../data/profile_repository.dart';

@Singleton(scope: authScope)
class WalletService {
  const WalletService(
    this._sharedPreferences,
    this._profileRepository,
    this._ecClient,
    this._analyticsManager,
  );

  final EspressoCashClient _ecClient;
  final SharedPreferences _sharedPreferences;
  final ProfileRepository _profileRepository;
  final AnalyticsManager _analyticsManager;

  @PostConstruct()
  void init() {
    final countryCode = _profileRepository.country;

    if (countryCode != null) {
      _analyticsManager.setProfileCountryCode(countryCode);
    }

    final wasSynced = _sharedPreferences.getBool(_countrySyncedKey) ?? false;
    if (!wasSynced) {
      _postCountry(countryCode);
    }
  }

  Future<void> _postCountry(String? countryCode) async {
    if (countryCode != null) {
      final request = WalletCountryRequestDto(countryCode: countryCode);
      await _ecClient.updateUserWalletCountry(request);
    }
    await _sharedPreferences.setBool(_countrySyncedKey, true);
  }
}

const _countrySyncedKey = 'walletCountrySynced';
