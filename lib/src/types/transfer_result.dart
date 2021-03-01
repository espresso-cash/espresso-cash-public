import 'package:solana_dart/src/types/json_rpc_response_object.dart';

class SimulateTxResult {
  SimulateTxResult._(dynamic value)
      : err = value['err'],
        logs = value['logs'];
  SimulateTxResult.fromJsonRpcResponseString(String jsonRpcResponseString)
      : this._(JsonRpcResponseObject.getValue(jsonRpcResponseString));

  final dynamic err;
  final List<dynamic> logs;
}
