import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/authorized.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/lockup.dart';

part 'stake_meta.g.dart';

@JsonSerializable()
class StakeMeta {
  const StakeMeta({
    required this.authorized,
    required this.lockup,
    required this.rentExemptReserve,
  });

  factory StakeMeta.fromJson(Map<String, dynamic> json) =>
      _$StakeMetaFromJson(json);

  final Authorized authorized;
  final Lockup lockup;
  final String rentExemptReserve;

  Map<String, dynamic> toJson() => _$StakeMetaToJson(this);
}
