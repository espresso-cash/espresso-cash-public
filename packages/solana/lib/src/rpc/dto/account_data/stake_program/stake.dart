import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/delegation.dart';

part 'stake.g.dart';

@JsonSerializable()
class Stake {
  const Stake({
    required this.delegation,
    required this.creditsObserved,
  });

  factory Stake.fromJson(Map<String, dynamic> json) => _$StakeFromJson(json);

  final Delegation delegation;
  final int creditsObserved;

  Map<String, dynamic> toJson() => _$StakeToJson(this);
}
