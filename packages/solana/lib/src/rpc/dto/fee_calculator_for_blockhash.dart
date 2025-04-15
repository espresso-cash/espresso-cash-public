import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/context.dart';
import 'package:solana/src/rpc/dto/fee_calculator.dart';

part 'fee_calculator_for_blockhash.g.dart';

/// The fee calculator for a blockhash
@JsonSerializable()
class FeeCalculatorForBlockhash {
  const FeeCalculatorForBlockhash({required this.feeCalculator});

  factory FeeCalculatorForBlockhash.fromJson(Map<String, dynamic> json) =>
      _$FeeCalculatorForBlockhashFromJson(json);

  /// [FeeCalculator] object, the fee schedule for this block hash
  final FeeCalculator feeCalculator;

  Map<String, dynamic> toJson() => _$FeeCalculatorForBlockhashToJson(this);
}

@JsonSerializable()
class FeeCalculatorForBlockhashResult extends ContextResult<FeeCalculatorForBlockhash?> {
  const FeeCalculatorForBlockhashResult({required super.context, required super.value});

  factory FeeCalculatorForBlockhashResult.fromJson(Map<String, dynamic> json) =>
      _$FeeCalculatorForBlockhashResultFromJson(json);

  Map<String, dynamic> toJson() => _$FeeCalculatorForBlockhashResultToJson(this);
}
