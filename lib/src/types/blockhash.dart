import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/types/fee_calculator.dart';
import 'package:solana/src/types/json_rpc_response_object.dart';

part 'blockhash.g.dart';

@JsonSerializable(createToJson: false)
class Blockhash {
  Blockhash({
    this.feeCalculator,
    this.blockhash,
  });

  factory Blockhash.fromJson(Map<String, dynamic> json) =>
      _$BlockhashFromJson(json);

  final FeeCalculator feeCalculator;
  final String blockhash;
}

@JsonSerializable(createToJson: false)
class BlockhashResponse extends JsonRpcResponse<ValueResponse<Blockhash>> {
  BlockhashResponse(ValueResponse<Blockhash> result) : super(result: result);

  factory BlockhashResponse.fromJson(Map<String, dynamic> json) =>
      _$BlockhashResponseFromJson(json);
}
