import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/stake.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/stake_meta.dart';

part 'stake_initialized_account_info.g.dart';

@JsonSerializable()
class StakeInitializedAccountInfo {
  const StakeInitializedAccountInfo({
    required this.meta,
    required this.stake,
  });

  factory StakeInitializedAccountInfo.fromJson(Map<String, dynamic> json) =>
      _$StakeInitializedAccountInfoFromJson(json);

  final StakeMeta meta;
  final Stake stake;

  Map<String, dynamic> toJson() => _$StakeInitializedAccountInfoToJson(this);
}
