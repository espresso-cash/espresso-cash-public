// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_commitment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockCommitment _$BlockCommitmentFromJson(Map<String, dynamic> json) =>
    BlockCommitment(
      commitment:
          (json['commitment'] as List<dynamic>?)?.map((e) => e as int).toList(),
      totalStake: json['totalStake'] as int,
    );

Map<String, dynamic> _$BlockCommitmentToJson(BlockCommitment instance) =>
    <String, dynamic>{
      'commitment': instance.commitment,
      'totalStake': instance.totalStake,
    };
