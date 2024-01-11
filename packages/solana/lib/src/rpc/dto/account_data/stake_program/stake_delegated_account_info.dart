import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/stake.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/stake_meta.dart';

part 'stake_delegated_account_info.g.dart';

@JsonSerializable()
class StakeDelegatedAccountInfo {
  const StakeDelegatedAccountInfo({
    required this.meta,
    required this.stake,
  });

  factory StakeDelegatedAccountInfo.fromJson(Map<String, dynamic> json) =>
      _$StakeDelegatedAccountInfoFromJson(json);

  final StakeMeta meta;
  final Stake stake;

  Map<String, dynamic> toJson() => _$StakeDelegatedAccountInfoToJson(this);
}
