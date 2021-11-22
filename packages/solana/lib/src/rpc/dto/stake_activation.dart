import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/stake_activation_state.dart';

part 'stake_activation.g.dart';

/// A stake activation description
@JsonSerializable(createFactory: true, includeIfNull: false)
class StakeActivation {
  const StakeActivation({
    required this.state,
    required this.active,
    required this.inactive,
  });

  factory StakeActivation.fromJson(Map<String, dynamic> json) =>
      _$StakeActivationFromJson(json);

  Map<String, dynamic> toJson() => _$StakeActivationToJson(this);

  /// Stake account's activation state
  final StakeActivationState state;

  /// Stake active during the epoch.
  final int active;

  /// Stake inactive during the epoch.
  final int inactive;
}
