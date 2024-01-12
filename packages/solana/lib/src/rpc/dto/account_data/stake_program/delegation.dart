import 'package:json_annotation/json_annotation.dart';

part 'delegation.g.dart';

@JsonSerializable()
class Delegation {
  const Delegation({
    required this.activationEpoch,
    required this.deactivationEpoch,
    required this.stake,
    required this.voter,
    required this.warmupCooldownRate,
  });

  factory Delegation.fromJson(Map<String, dynamic> json) =>
      _$DelegationFromJson(json);

  final String activationEpoch;
  final String deactivationEpoch;
  final String stake;
  final String voter;
  final double warmupCooldownRate;

  Map<String, dynamic> toJson() => _$DelegationToJson(this);
}
