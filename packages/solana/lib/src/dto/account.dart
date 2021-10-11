import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/account_data.dart';

part 'account.g.dart';

/// Response of the [`getAccountInfo`][get account info] rpc method.
///
/// [get account info]: https://docs.solana.com/developing/clients/jsonrpc-api#getaccountinfo
@JsonSerializable(createToJson: false)
class Account {
  Account({
    required this.owner,
    required this.lamports,
    required this.executable,
    required this.rentEpoch,
    this.data,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  final String owner;
  final int lamports;
  final bool executable;
  final int rentEpoch;

  @AccountDataConverter()
  final AccountData? data;
}
