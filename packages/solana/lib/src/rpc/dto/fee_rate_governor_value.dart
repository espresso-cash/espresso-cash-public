import 'package:json_annotation/json_annotation.dart';

part 'fee_rate_governor_value.g.dart';

/// The value of a fee rate governor
@JsonSerializable()
class FeeRateGovernorValue {
  const FeeRateGovernorValue({
    required this.burnPercent,
    required this.maxLamportsPerSignature,
    required this.minLamportsPerSignature,
    required this.targetLamportsPerSignature,
    required this.targetSignaturesPerSlot,
  });

  factory FeeRateGovernorValue.fromJson(Map<String, dynamic> json) =>
      _$FeeRateGovernorValueFromJson(json);

  /// Percentage of fees collected to be destroyed.
  final int burnPercent;

  /// Largest value lamportsPerSignature can attain for the next
  /// slot.
  final int maxLamportsPerSignature;

  /// Smallest value lamportsPerSignature can attain for the next
  /// slot.
  final int minLamportsPerSignature;

  /// Desired fee rate for the cluster.
  final int targetLamportsPerSignature;

  /// Desired signature rate for the cluster.
  final int targetSignaturesPerSlot;

  Map<String, dynamic> toJson() => _$FeeRateGovernorValueToJson(this);
}
