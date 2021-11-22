import 'package:json_annotation/json_annotation.dart';

part 'fee_calculator.g.dart';

/// A fee calculator
@JsonSerializable(createFactory: true, includeIfNull: false)
class FeeCalculator {
  const FeeCalculator({
    required this.lamportsPerSignature,
  });

  factory FeeCalculator.fromJson(Map<String, dynamic> json) =>
      _$FeeCalculatorFromJson(json);

  Map<String, dynamic> toJson() => _$FeeCalculatorToJson(this);

  /// number of lamports per signature in a transaction
  final int lamportsPerSignature;
}
