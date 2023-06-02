// ignore_for_file: avoid_positional_boolean_parameters

import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter.freezed.dart';

@freezed
class AccountFilter with _$AccountFilter {
  const factory AccountFilter() = _AccountFilterNone;

  const factory AccountFilter.byId(int id) = _AccountFilterId;

  const factory AccountFilter.byName(String name) = _AccountFilterName;

  const factory AccountFilter.byDerivationPath(Uri derivationPath) =
      _AccountFilterDerivationPath;

  const factory AccountFilter.byPublicKeyEncoded(String publicKeyEncoded) =
      _AccountFilterPublicKeyEncoded;

  const factory AccountFilter.byIsUserWallet(bool isUserWallet) =
      _AccountFilterIsUserWallet;

  const factory AccountFilter.byIsValid(bool isValid) = _AccountFilterIsValid;
}
