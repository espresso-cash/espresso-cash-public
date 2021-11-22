import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/fee_rate_governor_value.dart';

part 'fee_rate_governor.g.dart';

/// A fee rate governor
@JsonSerializable(createFactory: true, includeIfNull: false)
class FeeRateGovernor {
  const FeeRateGovernor({
    required this.feeRateGovernor,
  });

  factory FeeRateGovernor.fromJson(Map<String, dynamic> json) =>
      _$FeeRateGovernorFromJson(json);

  Map<String, dynamic> toJson() => _$FeeRateGovernorToJson(this);

  /// Fee rate governor
  final FeeRateGovernorValue feeRateGovernor;
}
