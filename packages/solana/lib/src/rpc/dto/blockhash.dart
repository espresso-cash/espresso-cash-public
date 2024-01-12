import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/context.dart';
import 'package:solana/src/rpc/dto/fee_calculator.dart';

part 'blockhash.g.dart';

/// Response of the [`getRecentBlockhash`][get recent blockhash] rpc method.
///
/// [get recent blockhash]: https://docs.solana.com/developing/clients/jsonrpc-api#getrecentblockhash
@JsonSerializable()
class Blockhash {
  const Blockhash({
    required this.feeCalculator,
    required this.blockhash,
  });

  factory Blockhash.fromJson(Map<String, dynamic> json) =>
      _$BlockhashFromJson(json);

  final FeeCalculator feeCalculator;
  final String blockhash;

  Map<String, dynamic> toJson() => _$BlockhashToJson(this);
}

@JsonSerializable()
class BlockhasValidResult extends ContextResult<bool> {
  const BlockhasValidResult({required super.context, required super.value});

  factory BlockhasValidResult.fromJson(Map<String, dynamic> json) =>
      _$BlockhasValidResultFromJson(json);

  Map<String, dynamic> toJson() => _$BlockhasValidResultToJson(this);
}
