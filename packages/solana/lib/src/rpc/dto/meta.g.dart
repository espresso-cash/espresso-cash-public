// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      err: json['err'] as Map<String, dynamic>?,
      fee: json['fee'] as int,
      preBalances:
          (json['preBalances'] as List<dynamic>).map((e) => e as int).toList(),
      postBalances:
          (json['postBalances'] as List<dynamic>).map((e) => e as int).toList(),
      innerInstructions: (json['innerInstructions'] as List<dynamic>?)
          ?.map((e) => InnerInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      preTokenBalances: (json['preTokenBalances'] as List<dynamic>)
          .map((e) => TokenBalance.fromJson(e as Map<String, dynamic>))
          .toList(),
      postTokenBalances: (json['postTokenBalances'] as List<dynamic>)
          .map((e) => TokenBalance.fromJson(e as Map<String, dynamic>))
          .toList(),
      logMessages: (json['logMessages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      rewards: (json['rewards'] as List<dynamic>?)
          ?.map((e) => Reward.fromJson(e as Map<String, dynamic>))
          .toList(),
      loadedAddresses: json['loadedAddresses'] == null
          ? null
          : LoadedAddresses.fromJson(
              json['loadedAddresses'] as Map<String, dynamic>),
      returnData: json['returnData'] == null
          ? null
          : ReturnData.fromJson(json['returnData'] as Map<String, dynamic>),
      computeUnitsConsumed: json['computeUnitsConsumed'] as int?,
    );
