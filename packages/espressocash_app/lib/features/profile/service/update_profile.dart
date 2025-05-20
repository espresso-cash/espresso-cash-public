import 'package:dfunc/dfunc.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/errors.dart';
import '../../analytics/analytics_manager.dart';
import '../../intercom/services/intercom_service.dart';
import '../../kyc_sharing/services/pending_kyc_service.dart';
import '../data/profile_repository.dart';

@injectable
class UpdateProfile {
  const UpdateProfile(
    this._client,
    this._intercomService,
    this._profileRepository,
    this._pendingKycService,
    this._analyticsManager,
  );

  final EspressoCashClient _client;
  final IntercomService _intercomService;
  final ProfileRepository _profileRepository;
  final PendingKycService _pendingKycService;
  final AnalyticsManager _analyticsManager;

  AsyncResult<void> call({
    String? firstName,
    String? lastName,
    String? countryCode,
    String? email,
    String? photoPath,
  }) => tryEitherAsync((_) async {
    if (countryCode != null && _profileRepository.country != countryCode) {
      _analyticsManager.setProfileCountryCode(countryCode);
      await _client.updateUserWalletCountry(countryCode);
      _intercomService.updateCountry(countryCode);
      _profileRepository.country = countryCode;
    }

    _pendingKycService.remove();

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
