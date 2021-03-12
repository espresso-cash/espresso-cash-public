import 'package:solana_dart/src/types/json_rpc_response_object.dart';

class SimulateTxResult {
  SimulateTxResult({this.err, this.logs});

  factory SimulateTxResult.fromJson(Map<String, dynamic> json) {
    return SimulateTxResult(
      err: json['err'],
      logs: json['logs'],
    );
  }

  factory SimulateTxResult.fromJsonRpcResponseString(
          String jsonRpcResponseString) =>
      SimulateTxResult.fromJson(
          JsonRpcResponseObject.getValue(jsonRpcResponseString));

  final dynamic err;
  final List<dynamic> logs;
}
