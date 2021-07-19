import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'account.freezed.dart';
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
    this.data = const AccountData.empty(),
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  final String owner;
  final int lamports;
  final bool executable;

  final AccountData data;

  final int rentEpoch;
}

@JsonSerializable(createToJson: false)
class AccountInfoResponse extends JsonRpcResponse<ValueResponse<Account>> {
  AccountInfoResponse(ValueResponse<Account> result) : super(result: result);

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoResponseFromJson(json);
}

@freezed
class AccountData with _$AccountData {
  const factory AccountData.fromString(String value) = StringAccountData;

  const factory AccountData.fromBytes(List<int> bytes) = BinaryAccountData;

  const factory AccountData.empty() = EmptyAccountData;

  factory AccountData.fromJson(dynamic data) {
    if (data == null) {
      return const AccountData.empty();
    } else if (data is String) {
      if (data == '') {
        return const AccountData.empty();
      }
      return AccountData.fromString(data);
    } else if (data is List) {
      if (data.length != 2) {
        throw const FormatException(
            'unexpected array of strings, cannot be account data');
      }
      if (data.last != 'base64') {
        throw FormatException('unexpected encoding "${data.last}"');
      }
      final dynamic base64String = data.first;
      if (base64String is! String) {
        throw FormatException('unexpected data "${data.first}"');
      }
      return AccountData.fromBytes(base64Decode(base64String));
    } else if (data is Map) {
      // TODO(IA): object data, must be converted into a valid thing
      return const AccountData.empty();
    } else {
      throw const FormatException('cannot decode account data');
    }
  }
}
