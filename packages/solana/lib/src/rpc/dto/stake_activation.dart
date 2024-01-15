import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/stake_activation_state.dart';

part 'stake_activation.g.dart';

/// A stake activation description
@JsonSerializable()
class StakeActivation {
  const StakeActivation({
    required this.state,
    required this.active,
    required this.inactive,
  });

  factory StakeActivation.fromJson(Map<String, dynamic> json) =>
      _$StakeActivationFromJson(json);

  /// Stake account's activation state
  final StakeActivationState state;

  /// Stake active during the epoch.
  final int active;

  /// Stake inactive during the epoch.
  final int inactive;

  Map<String, dynamic> toJson() => _$StakeActivationToJson(this);
}
