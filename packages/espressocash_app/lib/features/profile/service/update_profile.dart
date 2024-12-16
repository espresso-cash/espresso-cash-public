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
    String? firstName,
    String? lastName,
    String? countryCode,
    String? email,
    String? photoPath,
  }) =>
      tryEitherAsync((_) async {
        if (countryCode != null && _profileRepository.country != countryCode) {
          _analyticsManager.setProfileCountryCode(countryCode);
          final request = WalletCountryRequestDto(countryCode: countryCode);
          await _client.updateUserWalletCountry(request);
          _intercomService.updateCountry(countryCode);
          _profileRepository.country = countryCode;
        }

        if (firstName != null) {
          _profileRepository.firstName = firstName;
        }
        if (lastName != null) {
          _profileRepository.lastName = lastName;
        }
        if (photoPath != null) {
          _profileRepository.photoPath = photoPath;
        }
        if (email != null) {
          _profileRepository.email = email;
        }
      }).doOnLeftAsync(reportError);
}
