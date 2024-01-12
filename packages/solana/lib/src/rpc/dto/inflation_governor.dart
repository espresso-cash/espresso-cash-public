import 'package:json_annotation/json_annotation.dart';

part 'inflation_governor.g.dart';

/// An inflation governor
@JsonSerializable()
class InflationGovernor {
  const InflationGovernor({
    required this.initial,
    required this.terminal,
    required this.taper,
    required this.foundation,
    required this.foundationTerm,
  });

  factory InflationGovernor.fromJson(Map<String, dynamic> json) =>
      _$InflationGovernorFromJson(json);

  /// The initial inflation percentage from time 0.
  final double initial;

  /// Terminal inflation percentage.
  final double terminal;

  /// Rate per year at which inflation is lowered.\nRate
  /// reduction is derived using the target slot time in genesis
  /// config.
  final double taper;

  /// Percentage of total inflation allocated to the foundation.
  final double foundation;

  /// Duration of foundation pool inflation in years.
  final double foundationTerm;

  Map<String, dynamic> toJson() => _$InflationGovernorToJson(this);
}
