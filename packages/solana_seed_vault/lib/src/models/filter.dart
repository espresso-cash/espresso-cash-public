// ignore_for_file: avoid_positional_boolean_parameters, more readable

import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter.freezed.dart';

@freezed
sealed class AccountFilter with _$AccountFilter {
  const factory AccountFilter() = AccountFilterNone;

  const factory AccountFilter.byId(int id) = AccountFilterId;

  const factory AccountFilter.byName(String name) = AccountFilterName;

  const factory AccountFilter.byDerivationPath(Uri derivationPath) = AccountFilterDerivationPath;

  const factory AccountFilter.byPublicKeyEncoded(String publicKeyEncoded) =
      AccountFilterPublicKeyEncoded;

  const factory AccountFilter.byIsUserWallet(bool isUserWallet) = AccountFilterIsUserWallet;

  const factory AccountFilter.byIsValid(bool isValid) = AccountFilterIsValid;
}
