import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/fee_calculator.dart';

part 'fee_calculator_for_blockhash.g.dart';

/// The fee calculator for a blockhash
@JsonSerializable(createToJson: false)
class FeeCalculatorForBlockhash {
  const FeeCalculatorForBlockhash({
    required this.feeCalculator,
  });

  factory FeeCalculatorForBlockhash.fromJson(Map<String, dynamic> json) =>
      _$FeeCalculatorForBlockhashFromJson(json);

  /// [FeeCalculator] object, the fee schedule for this block hash
  final FeeCalculator feeCalculator;
}
