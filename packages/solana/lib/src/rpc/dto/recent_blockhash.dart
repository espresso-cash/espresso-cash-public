import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/context.dart';
import 'package:solana/src/rpc/dto/fee_calculator.dart';

part 'recent_blockhash.g.dart';

/// A recent blockhash
@JsonSerializable(createToJson: false)
class RecentBlockhash {
  const RecentBlockhash({
    required this.blockhash,
    required this.feeCalculator,
  });

  factory RecentBlockhash.fromJson(Map<String, dynamic> json) =>
      _$RecentBlockhashFromJson(json);

  /// Hash as base-58 encoded string
  final String blockhash;

  /// [FeeCalculator] object, the fee schedule for this block hash
  final FeeCalculator feeCalculator;
}

@JsonSerializable(createToJson: false)
class RecentBlockhashResult extends ContextResult<RecentBlockhash> {
  const RecentBlockhashResult({required super.context, required super.value});

  factory RecentBlockhashResult.fromJson(Map<String, dynamic> json) =>
      _$RecentBlockhashResultFromJson(json);
}
