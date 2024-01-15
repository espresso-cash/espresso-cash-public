import 'package:json_annotation/json_annotation.dart';

part 'fee_calculator.g.dart';

/// A fee calculator
@JsonSerializable()
class FeeCalculator {
  const FeeCalculator({
    required this.lamportsPerSignature,
  });

  factory FeeCalculator.fromJson(Map<String, dynamic> json) =>
      _$FeeCalculatorFromJson(json);

  /// number of lamports per signature in a transaction
  final int lamportsPerSignature;

  Map<String, dynamic> toJson() => _$FeeCalculatorToJson(this);
}
