import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/context.dart';

part 'latest_blockhash.g.dart';

/// A Latest Blockhash
@JsonSerializable()
class LatestBlockhash {
  const LatestBlockhash({
    required this.blockhash,
    required this.lastValidBlockHeight,
  });

  factory LatestBlockhash.fromJson(Map<String, dynamic> json) =>
      _$LatestBlockhashFromJson(json);

  /// A Hash as base-58 encoded string accounts
  final String blockhash;

  /// Last block height at which the blockhash will be valid
  final int lastValidBlockHeight;

  Map<String, dynamic> toJson() => _$LatestBlockhashToJson(this);
}

@JsonSerializable()
class LatestBlockhashResult extends ContextResult<LatestBlockhash> {
  const LatestBlockhashResult({required super.value, required super.context});

  factory LatestBlockhashResult.fromJson(Map<String, dynamic> json) =>
      _$LatestBlockhashResultFromJson(json);

  Map<String, dynamic> toJson() => _$LatestBlockhashResultToJson(this);
}
