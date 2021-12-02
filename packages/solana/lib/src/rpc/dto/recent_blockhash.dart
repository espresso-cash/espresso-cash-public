import 'package:json_annotation/json_annotation.dart';
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
