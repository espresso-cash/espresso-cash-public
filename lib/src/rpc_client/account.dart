part of 'rpc_client.dart';

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
  final dynamic data;
  final int rentEpoch;
}

@JsonSerializable(createToJson: false)
class _AccountInfoResponse extends JsonRpcResponse<ValueResponse<Account>> {
  _AccountInfoResponse(ValueResponse<Account> result) : super(result: result);

  factory _AccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$_AccountInfoResponseFromJson(json);
}
