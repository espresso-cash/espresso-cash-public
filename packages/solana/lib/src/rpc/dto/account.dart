import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/account_data.dart';

part 'account.g.dart';

/// An account
@JsonSerializable(createFactory: true, includeIfNull: false)
class Account {
  const Account({
    required this.lamports,
    required this.owner,
    required this.data,
    required this.executable,
    required this.rentEpoch,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  /// Number of lamports assigned to this account, as a u64
  final int lamports;

  /// base-58 encoded Pubkey of the program this account has been
  /// assigned to
  final String owner;

  /// Data associated with the account, either as encoded binary
  /// data or JSON format {<program>: <state>}, depending on
  /// encoding parameter
  @AccountDataConverter()
  final AccountData? data;

  /// Boolean indicating if the account contains a program (and
  /// is strictly read-only)
  final bool executable;

  /// The epoch at which this account will next owe rent, as u64
  final int rentEpoch;
}
