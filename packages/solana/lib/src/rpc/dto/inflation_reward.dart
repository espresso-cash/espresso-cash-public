import 'package:json_annotation/json_annotation.dart';

part 'inflation_reward.g.dart';

/// An inflation reward
@JsonSerializable()
class InflationReward {
  const InflationReward({
    required this.epoch,
    required this.effectiveSlot,
    required this.amount,
    required this.postBalance,
    required this.commission,
  });

  factory InflationReward.fromJson(Map<String, dynamic> json) =>
      _$InflationRewardFromJson(json);

  /// Epoch for which reward occurred.
  final int epoch;

  /// The slot in which the rewards are effective.
  final int effectiveSlot;

  /// Reward amount in lamports.
  final int amount;

  /// Post balance of the account in lamports.
  final int postBalance;

  /// Vote account commission when the reward was credited.
  final int commission;

  Map<String, dynamic> toJson() => _$InflationRewardToJson(this);
}
