import 'package:json_annotation/json_annotation.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';

part 'simulate_tx_result.g.dart';

@JsonSerializable(createToJson: false)
class SimulateTxResult {
  SimulateTxResult({this.err, this.logs});

  factory SimulateTxResult.fromJson(Map<String, dynamic> json) =>
      _$SimulateTxResultFromJson(json);

  factory SimulateTxResult.fromJsonRpcResponseString(
          String jsonRpcResponseString) =>
      SimulateTxResult.fromJson(
          JsonRpcResponseObject.getValue(jsonRpcResponseString));

  final dynamic err;
  final List<dynamic> logs;
}
