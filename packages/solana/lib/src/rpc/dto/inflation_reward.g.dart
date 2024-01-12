// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inflation_reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InflationReward _$InflationRewardFromJson(Map<String, dynamic> json) =>
    InflationReward(
      epoch: json['epoch'] as int,
      effectiveSlot: json['effectiveSlot'] as int,
      amount: json['amount'] as int,
      postBalance: json['postBalance'] as int,
      commission: json['commission'] as int,
    );

Map<String, dynamic> _$InflationRewardToJson(InflationReward instance) =>
    <String, dynamic>{
      'epoch': instance.epoch,
      'effectiveSlot': instance.effectiveSlot,
      'amount': instance.amount,
      'postBalance': instance.postBalance,
      'commission': instance.commission,
    };
