import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

@freezed
class Account with _$Account {
  const factory Account({
    required int id,
    required String name,
    required Uri derivationPath,
    required String publicKeyEncoded,
    required bool isUserWallet,
    required bool isValid,
  }) = _Account;
}

@freezed
class AccountFilter with _$AccountFilter {
  const factory AccountFilter.any() = _Any;
  const factory AccountFilter.isUserWallet() = _isUserWallet;
}
