import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_key.freezed.dart';
part 'account_key.g.dart';

/// A commonly used object that stores a single [pubkey]
@freezed
class AccountKey with _$AccountKey {
  const factory AccountKey({
    required String pubkey,
    required bool writable,
    required bool signer,
  }) = _AccountKey;

  factory AccountKey.fromJson(Map<String, dynamic> json) =>
      _$AccountKeyFromJson(json);
}
