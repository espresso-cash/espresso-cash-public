import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';
import 'package:solana/src/spl_token/token_amount.dart';

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
    this.data,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  final String owner;
  final int lamports;
  final bool executable;
  final int rentEpoch;

  @_AccountDataConverter()
  final AccountData? data;
}

@JsonSerializable(createToJson: false)
class AccountInfoResponse extends JsonRpcResponse<ValueResponse<Account>> {
  AccountInfoResponse(ValueResponse<Account> result) : super(result: result);

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoResponseFromJson(json);
}

@freezed
class AccountData with _$AccountData {
  const factory AccountData.fromBytes(List<int> bytes) = BinaryAccountData;

  const factory AccountData.fromString(String string) = StringAccountData;

  const factory AccountData.empty() = EmptyAccountData;

  const factory AccountData.splToken(ParsedSplTokenAccountData parsed) =
      SplTokenAccountData;

  const factory AccountData.generic(Map<String, dynamic> data) =
      GenericAccountData;
}

class _AccountDataConverter implements JsonConverter<AccountData?, dynamic> {
  const _AccountDataConverter();

  @override
  AccountData? fromJson(dynamic data) {
    if (data == null) {
      return null;
    } else if (data is String) {
      if (data == '') {
        throw const FormatException(
            'unexpected string for account data, expecting base64 data');
      }
      return AccountData.fromBytes(base64Decode(data));
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
    } else if (data is Map<String, dynamic>) {
      switch (data['program']) {
        // TODO(IA): add other program data
        case 'spl-token':
          return AccountData.splToken(ParsedSplTokenAccountData.fromJson(
            data['parsed'] as Map<String, dynamic>,
          ));
        default:
          return AccountData.generic(data);
      }
    } else {
      throw const FormatException('cannot decode account data');
    }
  }

  @override
  Map<String, dynamic> toJson(AccountData? object) {
    throw UnsupportedError('converting this object to json is not supported');
  }
}

@JsonSerializable()
class ParsedSplTokenAccountData {
  const ParsedSplTokenAccountData({
    required this.accountType,
    required this.info,
    required this.type,
  });

  factory ParsedSplTokenAccountData.fromJson(Map<String, dynamic> data) =>
      _$ParsedSplTokenAccountDataFromJson(data);

  final String? accountType;
  final ParsedSplTokenAccountDataInfo info;
  final String type;
}

@JsonSerializable()
class ParsedSplTokenAccountDataInfo {
  const ParsedSplTokenAccountDataInfo({
    required this.tokenAmount,
    required this.state,
    required this.isNative,
    required this.mint,
    required this.owner,
    this.delegate,
    this.delegateAmount,
  });

  factory ParsedSplTokenAccountDataInfo.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplTokenAccountDataInfoFromJson(json);

  final TokenAmount tokenAmount;
  final String state;
  final bool isNative;
  final String mint;
  final String owner;
  final String? delegate;
  final TokenAmount? delegateAmount;
}
