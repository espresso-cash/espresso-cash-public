import 'package:freezed_annotation/freezed_annotation.dart';

part 'parsed_stake_account_data.freezed.dart';
part 'parsed_stake_account_data.g.dart';

@Freezed(unionKey: 'type', fallbackUnion: 'unknown')
class ParsedStakeAccountData with _$ParsedStakeAccountData {
  const factory ParsedStakeAccountData.delegated({
    required StakeDelegatedAccountInfo info,
  }) = StakeDelegatedAccountData;

  const factory ParsedStakeAccountData.unknown(Map<String, dynamic> data) =
      StakeUnknownAccountData;

  factory ParsedStakeAccountData.fromJson(Map<String, dynamic> json) =>
      _$ParsedStakeAccountDataFromJson(json);
}

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
}

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
}

@JsonSerializable()
class Authorized {
  const Authorized({
    required this.staker,
    required this.withdrawer,
  });

  factory Authorized.fromJson(Map<String, dynamic> json) =>
      _$AuthorizedFromJson(json);

  final String staker;
  final String withdrawer;
}

@JsonSerializable()
class Lockup {
  const Lockup({
    required this.custodian,
    required this.epoch,
    required this.unixTimestamp,
  });

  factory Lockup.fromJson(Map<String, dynamic> json) => _$LockupFromJson(json);

  final String custodian;
  final int epoch;
  final int unixTimestamp;
}

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
}

@JsonSerializable()
class Stake {
  const Stake({
    required this.delegation,
    required this.creditsObserved,
  });

  factory Stake.fromJson(Map<String, dynamic> json) => _$StakeFromJson(json);

  final Delegation delegation;
  final int creditsObserved;
}
