import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authenticated/auth_scope.dart';
import '../../profile/data/profile_repository.dart';

@Singleton(scope: authScope)
class OnboardingRepository extends ChangeNotifier {
  OnboardingRepository(this._storage, this._profileRepository) {
    _profileRepository.addListener(_handleProfileUpdated);
  }

  final SharedPreferences _storage;
  final ProfileRepository _profileRepository;

  void _handleProfileUpdated() => notifyListeners();

  bool get hasSetupProfile => _profileRepository.hasAllRequiredFields;

  bool get hasFinishedOnboarding => hasSetupProfile;

  //TODO: deprecate
  bool get hasConfirmedPassphrase =>
      _storage.getBool(_passphraseConfirmedKey) ?? false;

  set hasConfirmedPassphrase(bool value) {
    _storage.setBool(_passphraseConfirmedKey, value);
    notifyListeners();
  }

  @override
  @disposeMethod
  void dispose() {
    _profileRepository.removeListener(_handleProfileUpdated);
    _storage.remove(_passphraseConfirmedKey);
    super.dispose();
  }
}

const _passphraseConfirmedKey = 'passphraseConfirmed';
