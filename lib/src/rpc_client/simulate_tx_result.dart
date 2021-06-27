part of 'rpc_client.dart';

/// Response of the [`simulateTransaction`][simulate transaction] rpc method
///
/// [simulate transaction]: https://docs.solana.com/developing/clients/jsonrpc-api#simulatetransaction
@JsonSerializable(createToJson: false)
class SimulateTxResult {
  SimulateTxResult({this.err, this.logs});

  factory SimulateTxResult.fromJson(Map<String, dynamic> json) =>
      _$SimulateTxResultFromJson(json);

  final Object? err;
  final List<dynamic>? logs;
}

@JsonSerializable(createToJson: false)
class _SimulateTxResultResponse
    extends JsonRpcResponse<ValueResponse<SimulateTxResult>> {
  _SimulateTxResultResponse(ValueResponse<SimulateTxResult> result)
      : super(result: result);

  factory _SimulateTxResultResponse.fromJson(Map<String, dynamic> json) =>
      _$_SimulateTxResultResponseFromJson(json);
}
