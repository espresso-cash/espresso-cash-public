import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/fee_rate_governor_value.dart';

part 'fee_rate_governor.g.dart';

/// A fee rate governor
@JsonSerializable()
class FeeRateGovernor {
  const FeeRateGovernor({
    required this.feeRateGovernor,
  });

  factory FeeRateGovernor.fromJson(Map<String, dynamic> json) =>
      _$FeeRateGovernorFromJson(json);

  /// Fee rate governor
  final FeeRateGovernorValue feeRateGovernor;

  Map<String, dynamic> toJson() => _$FeeRateGovernorToJson(this);
}
