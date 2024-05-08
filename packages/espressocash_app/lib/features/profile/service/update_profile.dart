import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/errors.dart';
import '../../analytics/analytics_manager.dart';
import '../../intercom/services/intercom_service.dart';
import '../data/profile_repository.dart';

@injectable
class UpdateProfile {
  const UpdateProfile(
    this._client,
    this._intercomService,
    this._profileRepository,
    this._analyticsManager,
  );

  final EspressoCashClient _client;
  final IntercomService _intercomService;
  final ProfileRepository _profileRepository;
  final AnalyticsManager _analyticsManager;

  AsyncResult<void> call({
    required String firstName,
    required String lastName,
    required String countryCode,
    required String email,
    required String? photoPath,
  }) =>
      tryEitherAsync((_) async {
        if (_profileRepository.country != countryCode) {
          _analyticsManager.setProfileCountryCode(countryCode);
          final request = WalletCountryRequestDto(countryCode: countryCode);
          await _client.updateUserWalletCountry(request);
          _intercomService.updateCountry(countryCode);
        }

        _profileRepository
          ..firstName = firstName
          ..lastName = lastName
          ..country = countryCode
          ..photoPath = photoPath
          ..email = email;
      }).doOnLeftAsync(reportError);
}
