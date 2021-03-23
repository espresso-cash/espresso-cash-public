import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/types/json_rpc_response_object.dart';

part 'simulate_tx_result.g.dart';

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
