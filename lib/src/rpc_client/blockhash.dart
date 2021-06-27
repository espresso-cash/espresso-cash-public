part of 'rpc_client.dart';

/// Response of the [`getRecentBlockhash`][get recent blockhash] rpc method.
///
/// [get recent blockhash]: https://docs.solana.com/developing/clients/jsonrpc-api#getrecentblockhash
@JsonSerializable(createToJson: false)
class Blockhash {
  Blockhash({
    required this.feeCalculator,
    required this.blockhash,
  });

  factory Blockhash.fromJson(Map<String, dynamic> json) =>
      _$BlockhashFromJson(json);

  final FeeCalculator feeCalculator;
  final String blockhash;
}

@JsonSerializable(createToJson: false)
class _BlockhashResponse extends JsonRpcResponse<ValueResponse<Blockhash>> {
  _BlockhashResponse(ValueResponse<Blockhash> result) : super(result: result);

  factory _BlockhashResponse.fromJson(Map<String, dynamic> json) =>
      _$_BlockhashResponseFromJson(json);
}
