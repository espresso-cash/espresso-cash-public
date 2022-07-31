// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) => Block(
      blockhash: json['blockhash'] as String,
      previousBlockhash: json['previousBlockhash'] as String,
      parentSlot: json['parentSlot'] as int,
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      signatures: (json['signatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      rewards: (json['rewards'] as List<dynamic>)
          .map((e) => Reward.fromJson(e as Map<String, dynamic>))
          .toList(),
      blockTime: json['blockTime'] as int?,
      blockHeight: json['blockHeight'] as int?,
    );
