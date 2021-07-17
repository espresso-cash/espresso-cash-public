import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'simulate_tx_result.g.dart';

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
class SimulateTxResultResponse
    extends JsonRpcResponse<ValueResponse<SimulateTxResult>> {
  SimulateTxResultResponse(ValueResponse<SimulateTxResult> result)
      : super(result: result);

  factory SimulateTxResultResponse.fromJson(Map<String, dynamic> json) =>
      _$SimulateTxResultResponseFromJson(json);
}
