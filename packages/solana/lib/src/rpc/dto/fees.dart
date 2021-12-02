import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/fee_calculator.dart';

part 'fees.g.dart';

/// A fee description object
@JsonSerializable(createToJson: false)
class Fees {
  const Fees({
    required this.blockhash,
    required this.feeCalculator,
    required this.lastValidBlockHeight,
  });

  factory Fees.fromJson(Map<String, dynamic> json) => _$FeesFromJson(json);

  /// Hash as base-58 encoded string
  final String blockhash;

  /// [FeeCalculator] object, the fee schedule for this block hash
  final FeeCalculator feeCalculator;

  /// Last block height at which a [blockhash] will be valid
  final int lastValidBlockHeight;
}
