import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/rpc/dto/account_data/account_data.dart';
import 'package:solana/src/rpc/dto/context.dart';
import 'package:solana/src/rpc/helpers.dart';

part 'account.freezed.dart';

part 'account.g.dart';

/// An account
@freezed
class Account with _$Account {
  const factory Account({
    /// Number of lamports assigned to this account, as a u64
    required int lamports,

    /// base-58 encoded Pubkey of the program this account has been
    /// assigned to
    required String owner,

    /// Data associated with the account, either as encoded binary
    /// data or JSON format {program: state}, depending on
    /// encoding parameter
    required AccountData? data,

    /// Boolean indicating if the account contains a program (and
    /// is strictly read-only)
    required bool executable,

    /// The epoch at which this account will next owe rent, as u64
    @JsonKey(fromJson: bigIntFromJson) required BigInt rentEpoch,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}

@JsonSerializable()
class AccountResult extends ContextResult<Account?> {
  const AccountResult({required super.context, required super.value});

  factory AccountResult.fromJson(Map<String, dynamic> json) => _$AccountResultFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResultToJson(this);
}

@JsonSerializable()
class MultipleAccountsResult extends ContextResult<List<Account?>> {
  const MultipleAccountsResult({required super.context, required super.value});

  factory MultipleAccountsResult.fromJson(Map<String, dynamic> json) =>
      _$MultipleAccountsResultFromJson(json);

  Map<String, dynamic> toJson() => _$MultipleAccountsResultToJson(this);
}
