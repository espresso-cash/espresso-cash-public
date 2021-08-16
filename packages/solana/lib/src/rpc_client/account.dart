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

@Freezed(unionKey: 'program', fallbackUnion: 'empty')
class AccountData with _$AccountData {
  const factory AccountData.fromString(String value) = StringAccountData;

  const factory AccountData.fromBytes(List<int> bytes) = BinaryAccountData;

  const factory AccountData.empty() = EmptyAccountData;

  @FreezedUnionValue('spl-token')
  const factory AccountData.splToken({
    required ParsedSplTokenAccountData parsed,
  }) = SplTokenAccountData;

  factory AccountData.fromJson(Map<String, dynamic> data) =>
      _$AccountDataFromJson(data);
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

  final String accountType;
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

  factory ParsedSplTokenAccountDataInfo.fromJson(Map<String, dynamic> data) =>
      _$ParsedSplTokenAccountDataInfoFromJson(data);

  final TokenAmount tokenAmount;
  final String? delegate;
  final TokenAmount? delegateAmount;
  final String state;
  final bool isNative;
  final String mint;
  final String owner;
}
