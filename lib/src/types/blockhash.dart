import 'package:json_annotation/json_annotation.dart';
import 'package:solana_dart/src/types/fee_calculator.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';

part 'blockhash.g.dart';

@JsonSerializable(createToJson: false)
class Blockhash {
  Blockhash({
    this.feeCalculator,
    this.blockhash,
  });

  final FeeCalculator feeCalculator;
  final String blockhash;

  factory Blockhash.fromJsonRpcResponseString(String jsonRpcResponseString) =>
      Blockhash.fromJson(JsonRpcResponseObject.getValue(jsonRpcResponseString));

  factory Blockhash.fromJson(Map<String, dynamic> json) =>
      _$BlockhashFromJson(json);
}
