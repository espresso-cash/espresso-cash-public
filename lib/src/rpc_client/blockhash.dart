import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/fee_calculator.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'blockhash.g.dart';

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
class BlockhashResponse extends JsonRpcResponse<ValueResponse<Blockhash>> {
  BlockhashResponse(ValueResponse<Blockhash> result) : super(result: result);

  factory BlockhashResponse.fromJson(Map<String, dynamic> json) =>
      _$BlockhashResponseFromJson(json);
}
