import 'package:json_annotation/json_annotation.dart';

part 'inflation_rate.g.dart';

/// An inflation rate
@JsonSerializable()
class InflationRate {
  const InflationRate({
    required this.total,
    required this.validator,
    required this.foundation,
    required this.epoch,
  });

  factory InflationRate.fromJson(Map<String, dynamic> json) =>
      _$InflationRateFromJson(json);

  /// Total inflation.
  final double total;

  /// Inflation allocated to validators.
  final double validator;

  /// Inflation allocated to the foundation.
  final double foundation;

  /// Epoch for which these values are valid.
  final double epoch;

  Map<String, dynamic> toJson() => _$InflationRateToJson(this);
}
