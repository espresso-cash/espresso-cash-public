// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return Meta(
    err: json['err'],
    rewards: (json['rewards'] as List<dynamic>?)
        ?.map((e) => Reward.fromJson(e as Map<String, dynamic>))
        .toList(),
    fee: json['fee'] as int,
    preBalances: json['preBalances'] as List<dynamic>,
    postBalances: json['postBalances'] as List<dynamic>,
    innerInstructions: json['innerInstructions'] as List<dynamic>,
    preTokenBalances: json['preTokenBalances'] as List<dynamic>,
    postTokenBalances: json['postTokenBalances'] as List<dynamic>,
    logMessages:
        (json['logMessages'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Reward _$RewardFromJson(Map<String, dynamic> json) {
  return Reward(
    pubkey: json['pubkey'] as String,
    lamports: json['lamports'] as int,
    postBalance: json['postBalance'] as int,
    rewardType: json['rewardType'] as String,
  );
}
