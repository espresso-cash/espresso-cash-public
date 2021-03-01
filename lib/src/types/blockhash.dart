import 'package:solana_dart/src/types/fee_calculator.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';

class Blockhash {
  Blockhash._(dynamic value)
      : blockhash = value['blockhash'],
        feeCalculator = FeeCalculator.fromDynamic(value['feeCalculator']) {
    if (blockhash == null) throw ('`blockhash\' must never be `null\'');
  }

  Blockhash.fromJsonRpcResponseString(String jsonRpcResponseString)
      : this._(JsonRpcResponseObject.getValue(jsonRpcResponseString));

  final FeeCalculator feeCalculator;
  final String blockhash;
}
